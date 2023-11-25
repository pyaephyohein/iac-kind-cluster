## Kind Cluster for Local testing

## To Do
- [x] Nginx ingress
- [ ] Add Node via env
- [ ] Grafana Stack
- [ ] Loki Stack
- [ ] FluentD
- [ ] ELK Stack
- [ ] Argocd
- [ ] Flux
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