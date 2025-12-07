# 🚀 DigitalOcean Droplet - Quick Start

## Create Droplet

1. **Size:** 2GB RAM minimum (4GB+ recommended)
2. **OS:** Ubuntu 22.04 LTS
3. **Region:** Frankfurt or Singapore
4. **SSH Keys:** Add your SSH key

## Deploy

```bash
export DROPLET_IP=your.droplet.ip
chmod +x deploy-to-droplet.sh
./deploy-to-droplet.sh
```

## Verify

```bash
ssh root@your.droplet.ip
cd /opt/97k
docker-compose ps
```

## Configure

```bash
# Update environment variables
nano /opt/97k/.env

# Restart services
docker-compose restart
```

## SSL Setup (Production)

```bash
apt install -y certbot
certbot certonly --standalone -d 97k.ru -d www.97k.ru

# Update nginx.conf with certificate paths
# Restart nginx
```

## Access

- Frontend: `http://your.droplet.ip:3001`
- Backend: `http://your.droplet.ip:3000`
- API: `http://your.droplet.ip:3000/api`

## Useful Commands

```bash
# View logs
docker-compose logs -f backend

# Check resources
docker stats

# Backup database
docker-compose exec -T postgres pg_dump -U 97k 97k_db > backup.sql

# Update code
cd /opt/97k && git pull && docker-compose up -d --build
```

## Monitoring

```bash
# Install Portainer (Web UI for Docker)
docker run -d -p 8000:8000 -p 9000:9000 \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  portainer/portainer-ce

# Access: http://your.droplet.ip:9000
```

For detailed guide, see [DROPLET-DEPLOYMENT.md](./DROPLET-DEPLOYMENT.md)
