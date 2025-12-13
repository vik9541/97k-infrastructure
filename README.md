# 97k-infrastructure - DevOps Module of super-brain-digital-twin

> **MAIN PROJECT:** [super-brain-digital-twin v5.0 (97v.ru)](https://github.com/vik9541/super-brain-digital-twin)  
> **MASTER DOC:** [MASTER_README.md](https://github.com/vik9541/super-brain-digital-twin/blob/main/MASTER_README.md)  
> **ARCHITECTURE:** [STRUCTURE.md](https://github.com/vik9541/super-brain-digital-twin/blob/main/STRUCTURE.md)

---

## This Module: DevOps and Infrastructure

- Status: PRODUCTION READY
- Stack: Docker, NGINX, Kubernetes, GitHub Actions
- Infrastructure: DigitalOcean DOKS + VPS Backup
- Domains: 97v.ru, api.97k.ru, www.97k.ru

## Services

- NGINX Reverse Proxy (SSL/TLS, load balancing)
- Docker and Docker Compose (containerization)
- Kubernetes (auto-scaling, health checks)
- CI/CD Pipeline (GitHub Actions)
- Monitoring (Prometheus + Grafana)

## Deployment

docker-compose up -d          # Local development
./scripts/deploy-to-droplet.sh # Production deployment
kubectl apply -f k8s/         # Kubernetes deployment

## Related Modules

- [super-brain-digital-twin](https://github.com/vik9541/super-brain-digital-twin) - Main Project
- [97k-backend](https://github.com/vik9541/97k-backend) - NestJS API
- [97k-frontend](https://github.com/vik9541/97k-frontend) - React app
- [97k-database](https://github.com/vik9541/97k-database) - PostgreSQL schema
- [97k-n8n-workflows](https://github.com/vik9541/97k-n8n-workflows) - Automation
- [97k-97v-specs](https://github.com/vik9541/97k-97v-specs) - Specs

---

**Status**: PRODUCTION | **Type**: DevOps | **Module of**: super-brain-digital-twin v5.0
