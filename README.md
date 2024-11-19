# jetson_setup

## Setup Jetson

0. `mkdir $HOME/workspace; cd $HOME/workspace; git clone git@github.com:AgriSwarm/jetson_setup.git setup; cd setup`
1. `bash initial_setup.sh`

2. Register the pub-key into the GitHub.

3. `sudo -E -u $USER bash install_jetson.sh`

4. Setting variable like `echo -e "DRONE_ID=0\nexport FCU_PORT=\"/dev/ttyTHS1\"" >> ~/.bash_profile`

## Links

1. https://agriswarm.github.io/agri_docs/software_install.html