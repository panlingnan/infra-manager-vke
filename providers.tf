provider "volcenginecc" {
  access_key = var.access_key
  endpoints = {
    cloudcontrolapi = "open.stable.volcengineapi-test.com"
  }
  secret_key = var.secret_key
  region     = var.region
}
