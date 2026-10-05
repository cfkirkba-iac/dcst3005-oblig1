variable "short_name" {
  type        = string
  description = "Kort personlig navn som brukes for å gjøre Azure-ressursnavn unike"
}

variable "location" {
  type        = string
  description = "Azure-regionen backend-ressursene skal opprettes i"
}