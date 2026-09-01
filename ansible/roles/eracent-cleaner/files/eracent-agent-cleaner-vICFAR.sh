#!/bin/sh

KNOWN_AGENTS="ECM EPA EPM SUM EUA EDA FLW"
PSARG="-A -o pid,args"
BASEDIR=

removeInitdStuff() {
	is_known=''
	if command -v chkconfig 1>/dev/null 2>/dev/null	
	then
		is_known=`chkconfig --list "Eracent${1}Service" 2>/dev/null`
	elif command -v update-rc.d 2>&1 1>/dev/null ; # then use update-rc.d
	then
		update-rc.d -f Eracent${1}Service remove 2>&1 > /dev/null
	fi

	if [ -n "$is_known" ]
	then
		chkconfig --del Eracent${1}Service
	fi
	for idir in /etc/rc*d /sbin/rc*d /sbin/init.d /etc/init.d
	do
		if [ -d "$idir" ]
		then
			for x in `find "$idir" -name "S*Eracent${1}Service" -o -name "K*Eracent${1}Service" -o -name "Eracent${1}Service" 2>/dev/null`
			do
				rm -f "$x"
			done
		fi
	done
}

doKillService() {
	svcPIDFile=${BASEDIR}/${1}/Eracent${1}Service.pid
	svcPID=`cat ${svcPIDFile} 2>/dev/null`

	[ -z "${svcPID}" ] && return
	if [ -n "ps ${PSARG} | grep Eracent${1}Service | grep -v grep | grep ${svcPID}" ]
	then
		kill -9 "${svcPID}"
	fi
}

CleanupProcesses()
{
	pkill -9 -f "Eracent(ECM|EPA|EPM|SUM|EUA|EDA|FLW)Service"
}

stopServiceAndUninstallSystemd() {
	SYSTEMDDIR=
	for x in /usr/lib/systemd/system /lib/systemd/system
	do
		if [ -d "$x" ]
		then
			SYSTEMDDIR="$x"
		fi
	done
	if [ "x${SYSTEMDDIR}" = "x" ]
	then # no systemd directory. exiting . . .
		return 1
	fi

	#checking for systemd service start / stop script
	svc="Eracent${1}Service"
	if [ ! -f ${SYSTEMDDIR}/${svc}* ] ;
	then # no service start / stop script in systemd dir . . .
		return 2
	fi

	#if [ "x${SYSTEMDDIR}/${svc}.service" = "x" ] # obsolete
	if [ -f "${SYSTEMDDIR}/${svc}.service" ] ;
	then
		systemctl stop "${svc}"
		systemctl disable "${svc}"
		rm -f "${SYSTEMDDIR}/${svc}.service"
	fi

	return 0
}

stopServiceAndUninstallSysV() {
	# stop services
	for x in /etc/init.d /etc/rc*d /sbin/init.d ${BASEDIR}; do
		[ -f "$x/Eracent${1}Service" ] && break
	done

	svcScript="$x/Eracent${1}Service"

	if [ -f "${svcScript}" ]
	then
		res=`${svcScript} stop; echo $?`

		if [ "x$res" = "x0" ] ;
		then
			:
		else
			doKillService "${1}"
		fi
	else
		echo "Service ${1} not installed."
	fi
	removeInitdStuff "${1}"
}

CleanAgents()
{
	for agent in ${KNOWN_AGENTS}; do
		if [ -d "${BASEDIR}/${agent}" ]; then
			rm -rf "${BASEDIR}/${1}"
		fi
	done	
}

CleanCommonFiles()
{	
	rm -rf "${BASEDIR}/cache"
}

StopServices()
{
	echo "Stopping services, this may take a while..."
	for agent in ${KNOWN_AGENTS}; do
		stopServiceAndUninstallSystemd "$agent"
		stopServiceAndUninstallSysV "$agent"
	done
}

doCheckBaseDir() {
	hasEracentSuffix=no
	isAbsolute=no
	#if [ ! -d "${1}" ] ; then return 1; fi
	if [ "$1" = "/" ] ; then return 1; fi
	case "${1}" in *".."*) return 1;; esac
	case "${1}" in /*) isAbsolute=yes ;; esac
	if [ "${isAbsolute}" = "no" ] ; then return 1; fi
	case "${1}" in */Eracent) hasEracentSuffix=yes ;; esac
	case "${1}" in */Eracent/) hasEracentSuffix=yes ;; esac
	if [ "${hasEracentSuffix}" = "no" ] ; then return 1; fi
	return 0;
}

RemoveRpm()
{
	echo "Removing RPM packages"
	rpm -qa --qf '%{NAME}\t%{VENDOR}\n' | grep -i eracent | cut -f1 | \
	while read package;	do
																	   
		BASEDIR="`rpm -ql $package | head -n1`"
		doCheckBaseDir "$BASEDIR"
		if [ $? -eq 0 ]; then
			rpm -e --nodeps --noscripts $package
			CleanAgents
			CleanCommonFiles
		fi
	done	
}

main()
{
	StopServices
	#some processes may be decoupled from init scripts/service units, cull them
	CleanupProcesses
	RemoveRpm
}

main