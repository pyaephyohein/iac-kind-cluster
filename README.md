## Kind Cluster for Local testing

## To Do
- [x] Nginx ingress
- [ ] Add Node via env
- [x] Grafana
- [x] Prometheus
- [ ] Dashboards
- [ ] Loki
- [ ] FluentD
- [ ] ELK Stack
- [ ] Argocd
- [ ] Flux
- [ ] Sonarqube
- [ ] Terragrunt
- [ ] Testing



## How to run

Edit [env.json](env.json)

```bash
terraform init
```
```bash
terraform plan --var-file=env.json
```
```bash
terraform apply --var-file=env.json
```

## How to destory
```bash
terraform destroy
```