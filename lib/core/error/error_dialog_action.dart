enum ErrorActionType {
  retry, // Renders on fail widget and dialog
  autoRetry, // Doesn't render
  openWifiSettings, // Renders on fail widget and dialog
  contactSupport, // Renders on fail widget and dialog
  sendLogs, // Doesn't render
  close, // Renders on dialog
}
