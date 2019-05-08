<!-- vi: set sts=4 ts=4 sw=4 : -->
## Install
- Once, with AdminRights/Root:
	- Install Virtualbox + GuestAdditions (+optional: extras)
	- Install Vagrant, and then with normal priviledges install these plugins:
      ```
	   vagrant install plugin winrm winrm-fs winrm-elevated vagrant-vbguest
	  ```

- Launch VM commands:
  ```
  vagrant up
  vagrant reload --provision  # to apply any edits
  ```


## Contents

	Windows/	Vagrant development image
