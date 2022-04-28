# output "name" {
#   value = azurerm_linux_virtual_machine.vm.name
# }

# output "id" {
#   value = azurerm_linux_virtual_machine.vm.id
# }

# output "private_ip_address" {
#   value = azurerm_linux_virtual_machine.vm.private_ip_address
# }

# output "identity" {
#   value = one(azurerm_linux_virtual_machine.vm.identity)

output "app_service_url" {
  value       = azurerm_app_service.app-service.default_site_hostname
  description = "Default URL to access the app service." 
}