crowdstrike
=========

This is to install CrowdStrike on a resource. As it is meant to be on all resources, it should be a part of the Boilerplate. This is required to run Crowdstrike on resources. This does not automatically run it on new resources.

Requirements
------------

The base resource to create this AMI requires access to the "endpointsecurity" Atlas Yum repo. 

Role Variables
--------------

N/A

Dependencies
------------

- Amazon Linux 2

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

Internal?