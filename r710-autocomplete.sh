_r710(){
  local -a subcmds
  subcmds=(
    'start-server:Starts the server and sets the fans to the defined percentage' 
    'stop-server:Stops the server'
    'set-fans:Sets the fan speed to the defined percentage'
    'reset-fans:Enables automatic fan speed control'
    'get-temp:Get current ambient temperature'
    'get-fans:Get current fan speeds'
  )
  _describe 'r710' subcmds
}
compdef _r710 r710