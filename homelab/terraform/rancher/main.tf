provider "rancher2" {
  alias = "bootstrap"

  api_url   = "https://rancher.k3s.stiil.dk"
  bootstrap = true
  timeout = "30s"
  insecure  = true
}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap

  initial_password = var.BOOTSTRAP_PASSWORD
  telemetry = false
}

provider "rancher2" {
  alias = "admin"

  api_url   = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
  insecure  = true
}

resource "rancher2_auth_config_openldap" "openldap" {
  provider                           = rancher2.admin
  servers                            = ["diskstation.stiil.local"]
  service_account_distinguished_name = format("%s,cn=users,%s",var.service_account_uid, var.dn_base)
  service_account_password           = var.LDAP_SA_PASSWORD
  user_search_base                   = format("cn=users,%s",var.dn_base)
  port                               = 389
  test_username                      = var.TESTUSER_NAME
  test_password                      = var.TESTUSER_PASSWORD
  access_mode                        = "unrestricted"
  group_dn_attribute                 = "dn"
  group_member_user_attribute        = "dn"
  group_object_class                 = "posixGroup"
  group_search_base                  = format("cn=groups,%s",var.dn_base)
  nested_group_membership_enabled    = true
  user_name_attribute                = "cn"
}

/*
data "rancher2_cluster" "local" {
  provider = rancher2.admin
  name     = "local"
}

data "rancher2_project" "system" {
  provider   = rancher2.admin
  cluster_id = data.rancher2_cluster.local.id
  name       = "System"
}

resource "rancher2_namespace" "traefik" {
  provider   = rancher2.admin
  project_id = data.rancher2_project.system.id
  name = "traefik"
}
resource "rancher2_app_v2" "rancher-monitoring" {
  provider   = rancher2.admin
  cluster_id = data.rancher2_cluster.local.id
  project_id = data.rancher2_project.system.id
  name       = "rancher-monitoring"
  namespace  = "cattle-monitoring-system"
  repo_name  = "rancher-charts"
  chart_name = "rancher-monitoring"
  chart_version = "101.0.0+up19.0.3"
  values = <<EOF
k3sServer:
  enabled: true
k3sControllerManager:
  enabled: true
k3sScheduler:
  enabled: true
k3sProxy:
  enabled: true
EOF
}

resource "rancher2_app_v2" "longhorn" {
  provider   = rancher2.admin
  cluster_id = data.rancher2_cluster.local.id
  project_id = data.rancher2_project.system.id
  name       = "longhorn"
  namespace  = "longhorn-system"
  repo_name  = "rancher-charts"
  chart_name = "longhorn"
  chart_version = "101.1.0+up1.3.2"
  values = <<EOF
ingress:
  enabled: true
  host: longhorn.k3s.stiil.dk
  tls: true
  tlsSecret: longhorn.k3s.stiil.dk
  annotations:    
    cert-manager.io/cluster-issuer: staging-issuer
    traefik.ingress.kubernetes.io/router.tls: "true"
    traefik.ingress.kubernetes.io/router.middlewares: "traefik-authelia-auth-transform@kubernetescrd,traefik-authelia-auth@kubernetescrd"
EOF
}
*/