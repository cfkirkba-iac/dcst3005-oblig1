variable "rg_name" {
  type        = string
  description = "Navnet på ressursgruppen nettverket skal opprettes i"
}

variable "location" {
  type        = string
  description = "Azure-regionen nettverksressursene skal opprettes i"
}

variable "base_name" {
  type        = string
  description = "Felles navnegrunnlag for nettverksressursene"
}

variable "address_space" {
  type        = string
  description = "Adresserommet til det virtuelle nettverket"
}

variable "subnets" {
  type        = map(number)
  description = "Subnett som skal opprettes: navn => netnum innenfor adresserommet"
}

variable "tags" {
  type        = map(string)
  description = "Felles tags som skal legges på nettverksressursene"
}