export EDITOR=vim
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
# export NVIM_TUI_ENABLE_TRUE_COLOR=1

export JAVA_HOME=`/usr/libexec/java_home`
# JAVA_TOOL_OPTIONS
export _JAVA_OPTIONS=-Djava.awt.headless=true
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export M2_HOME=/usr/local/apache-maven-3.2.3
export PATH=/usr/local/bin:/usr/local/sbin:$M2_HOME/bin:$HOME/bin:$PATH

export MAVEN_OPTS='-Xmx1000M -XX:MaxPermSize=800M'

[ -f ~/.profile.local ] && source ~/.profile.local
