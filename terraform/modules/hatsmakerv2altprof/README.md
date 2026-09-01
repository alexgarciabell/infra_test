The configs in this section are modifications that build upon what is in the "hatsmakerv2" module.
These are separate so as not to break current versions.

The only reason why this exists at the moment is because Terraform 0.11.x does not recognize null
 as a value and therefore, hacks are needed to trick it into not setting a variable. This is
 currently only needed for the Open Internet effort though it should allow using any appropriate
 host to allow specifying an IAM User/credentials to access a different account. 

The following changes have been made:
* New variables have been added:
    * aws_profile

