# sysprov
Task 1: 
playbook.yaml file is used to install the modules, check http status and create a new index.html file 
remote user is tested on aws instance which can be changed accordingly
Webserver hosts are public IPs of AWS instances which are used for testing that needs to be changed accordingly
Command ansible-playbook -i hosts playbook.yaml needs to be run from remote host after installing ansible

Task 2:
Perl script is corrected and error details are added as comment in the same file broken_bits.pl
Inorder to run that script install Perl in local machine and execute below command
perl broken_bits.pl

Task 3:
Converted existing perl script to python and it is available in the file broken_bits.py
inorder to run that script install python and execute below command
python broken_bits.py

Task 4:
Have used terraform to provison tha infrastructure (AWS) required for task 1 and created load balancer with instances available in three different availability zones which will be resilient to failures
Inorder to run terraform script execute below commands

terraform init
terraform validate
terraform apply --auto-approve
