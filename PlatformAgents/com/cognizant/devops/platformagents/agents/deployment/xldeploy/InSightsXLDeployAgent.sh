#! /bin/sh
# /etc/init.d/InSightsXLDeployAgent

### BEGIN INIT INFO
# Provides: Runs a Python script on startup
# Required-Start: BootPython start
# Required-Stop: BootPython stop
# Default-Start: 2 3 4 5
# Default-stop: 0 1 6
# Short-Description: Simple script to run python program at boot
# Description: Runs a python program at boot
### END INIT INFO
#export INSIGHTS_AGENT_HOME=/home/ec2-user/insightsagents
source /etc/profile

case "$1" in
  start)
    if [[ $(ps aux | grep '[d]eployment.xldeploy.XLDeployAgent' | awk '{print $2}') ]]; then
     echo "InSightsXLDeployAgent already running"
    else
     echo "Starting InSightsXLDeployAgent"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/xldeploy
     python -c "from com.cognizant.devops.platformagents.agents.deployment.xldeploy.XLDeployAgent import XLDeployAgent; XLDeployAgent()" &
    fi
    if [[ $(ps aux | grep '[d]eployment.xldeploy.XLDeployAgent' | awk '{print $2}') ]]; then
     echo "InSightsXLDeployAgent Started Sucessfully"
    else
     echo "InSightsXLDeployAgent Failed to Start"
    fi
    ;;
  stop)
    echo "Stopping InSightsXLDeployAgent"
    if [[ $(ps aux | grep '[d]eployment.xldeploy.XLDeployAgent' | awk '{print $2}') ]]; then
     sudo kill -9 $(ps aux | grep '[d]eployment.xldeploy.XLDeployAgent' | awk '{print $2}')
    else
     echo "InSIghtsXLDeployAgent already in stopped state"
    fi
    if [[ $(ps aux | grep '[d]eployment.xldeploy.XLDeployAgent' | awk '{print $2}') ]]; then
     echo "InSightsXLDeployAgent Failed to Stop"
    else
     echo "InSightsXLDeployAgent Stopped"
    fi
    ;;
  restart)
    echo "Restarting InSightsXLDeployAgent"
    if [[ $(ps aux | grep '[d]eployment.xldeploy.XLDeployAgent' | awk '{print $2}') ]]; then
     echo "InSightsXLDeployAgent stopping"
     sudo kill -9 $(ps aux | grep '[d]eployment.xldeploy.XLDeployAgent' | awk '{print $2}')
     echo "InSightsXLDeployAgent stopped"
     echo "InSightsXLDeployAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/xldeploy
     python -c "from com.cognizant.devops.platformagents.agents.deployment.xldeploy.XLDeployAgent import XLDeployAgent; XLDeployAgent()" &
     echo "InSightsXLDeployAgent started"
    else
     echo "InSightsXLDeployAgent already in stopped state"
     echo "InSightsXLDeployAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/xldeploy
     python -c "from com.cognizant.devops.platformagents.agents.deployment.xldeploy.XLDeployAgent import XLDeployAgent; XLDeployAgent()" &
     echo "InSightsXLDeployAgent started"
    fi
    ;;
  status)
    echo "Checking the Status of InSightsXLDeployAgent"
    if [[ $(ps aux | grep '[d]eployment.xldeploy.XLDeployAgent' | awk '{print $2}') ]]; then
     echo "InSightsXLDeployAgent is running"
    else
     echo "InSightsXLDeployAgent is stopped"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/InSightsXLDeployAgent {start|stop|restart|status}"
    exit 1
    ;;
esac
exit 0
