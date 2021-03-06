#! /bin/sh
# /etc/init.d/InSightsSnowAgent

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
    if [[ $(ps aux | grep '[i]tsm.snow.snowAgent' | awk '{print $2}') ]]; then
     echo "InSightsSnowAgent already running"
    else
     echo "Starting InSightsSnowAgent"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/snow
     python -c "from com.cognizant.devops.platformagents.agents.itsm.snow.snowAgent import snowAgent; snowAgent()" &
    fi
    if [[ $(ps aux | grep '[i]tsm.snow.snowAgent' | awk '{print $2}') ]]; then
     echo "InSightsSnowAgent Started Sucessfully"
    else
     echo "InSightsSnowAgent Failed to Start"
    fi
    ;;
  stop)
    echo "Stopping InSightsSnowAgent"
    if [[ $(ps aux | grep '[i]tsm.snow.snowAgent' | awk '{print $2}') ]]; then
     sudo kill -9 $(ps aux | grep '[i]tsm.snow.snowAgent' | awk '{print $2}')
    else
     echo "InSIghtsSnowAgent already in stopped state"
    fi
    if [[ $(ps aux | grep '[i]tsm.snow.snowAgent' | awk '{print $2}') ]]; then
     echo "InSightsSnowAgent Failed to Stop"
    else
     echo "InSightsSnowAgent Stopped"
    fi
    ;;
  restart)
    echo "Restarting InSightsSnowAgent"
    if [[ $(ps aux | grep '[i]tsm.snow.snowAgent' | awk '{print $2}') ]]; then
     echo "InSightsSnowAgent stopping"
     sudo kill -9 $(ps aux | grep '[i]tsm.snow.snowAgent' | awk '{print $2}')
     echo "InSightsSnowAgent stopped"
     echo "InSightsSnowAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/snow
     python -c "from com.cognizant.devops.platformagents.agents.itsm.snow.snowAgent import snowAgent; snowAgent()" &
     echo "InSightsSnowAgent started"
    else
     echo "InSightsSnowAgent already in stopped state"
     echo "InSightsSnowAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/snow
     python -c "from com.cognizant.devops.platformagents.agents.itsm.snow.snowAgent import snowAgent; snowAgent()" &
     echo "InSightsSnowAgent started"
    fi
    ;;
  status)
    echo "Checking the Status of InSightsSnowAgent"
    if [[ $(ps aux | grep '[i]tsm.snow.snowAgent' | awk '{print $2}') ]]; then
     echo "InSightsSnowAgent is running"
    else
     echo "InSightsSnowAgent is stopped"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/InSightsSnowAgent {start|stop|restart|status}"
    exit 1
    ;;
esac
exit 0
