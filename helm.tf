resource "helm_release" "nginx_ingress" {
  name       = local.ingress_controller_release_name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = local.ingress_controller_release_name
  depends_on = [module.eks_cluster]
  set = [
    {
      name  = "fullnameOverride"
      value = local.ingress_controller_release_name
    },
    {
      name  = "controller.name "
      value = local.ingress_controller_controller_name
    }
  ]
  values = [
    "${file("resources/ingress-values.yaml")}"
  ]
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.12.3"
  depends_on = [module.eks_cluster]
  set = [
    {
      name  = "installCRDs"
      value = "true"
    }
  ]
}
