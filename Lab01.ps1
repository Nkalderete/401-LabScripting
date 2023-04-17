# Set the time limit (in seconds)
$TimeLimit = 600

# Start a loop that will run indefinitely
while ($true) {

  # Get the idle time of the system (in seconds)
  $IdleTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
  $IdleTime = (Get-Date) - $IdleTime
  $IdleTime = $IdleTime.TotalSeconds

  # Check if the idle time exceeds the time limit
  if ($IdleTime -ge $TimeLimit) {

    # Lock the screen
    rundll32.exe user32.dll,LockWorkStation

    # Wait for the user to return and reset the idle time
    do {
      Start-Sleep -Seconds 1
      $IdleTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
      $IdleTime = (Get-Date) - $IdleTime
      $IdleTime = $IdleTime.TotalSeconds
    } while ($IdleTime -ge $TimeLimit)
  }

  # Wait for a short period of time before checking again
  Start-Sleep -Seconds 30
}


