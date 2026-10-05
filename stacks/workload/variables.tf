variable "environment" {
  type        = string
  description = "Miljøet workload-ressursene rulles ut til"
}

variable "location" {
  type        = string
  description = "Azure-regionen workload-ressursene opprettes i"
}

variable "short_name" {
  type        = string
  description = "Kort personlig navn som brukes i ressursnavn"
}

variable "remote_state_config" {
  type        = any
  description = "Backend-konfigurasjon som brukes for å lese network-state"
}