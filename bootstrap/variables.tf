variable "short_name" {
  type        = string
  description = "Kort personlig navn som brukes for å gjøre Azure-ressursnavn unike"
}

variable "location" {
  type        = string
  description = "Azure-regionen backend-ressursene skal opprettes i"
}

variable "pipeline_principal_id" {
  type        = string
  description = "Object-ID til service principal-en som GitHub Actions bruker"
}