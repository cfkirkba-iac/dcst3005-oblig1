variable "environment" {
  type        = string
  description = "Miljøet infrastrukturen rulles ut til"
}

variable "location" {
  type        = string
  description = "Azure-regionen infrastrukturen opprettes i"
}

variable "short_name" {
  type        = string
  description = "Kort personlig navn som gjør ressursnavn unike"
}

variable "address_space" {
  type        = string
  description = "Adresserommet som brukes av det virtuelle nettverket"
}