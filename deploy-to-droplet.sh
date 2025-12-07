#!/bin/bash

# 97k Automated Deployment to DigitalOcean Droplet
# Usage: DROPLET_IP=your.ip.address ./deploy-to-droplet.sh

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}=== 97k Deployment Script ===${NC}"

if [ -z "$DROPLET_IP" ]; then
    echo -e "${RED}Error: DROPLET_IP not set${NC}"
    echo "Usage: DROPLET_IP=your.droplet.ip ./deploy-to-droplet.sh"
    exit 1
fi

echo -e "${YELLOW}Target: $DROPLET_IP${NC}"

# Step 1: Update System
echo -e "${YELLOW}[1/7] Updating system...${NC}"
ssh root@$DROPLET_IP 'apt update && apt upgrade -y && apt install -y curl wget git'

# Step 2: Install Docker
echo -e "${YELLOW}[2/7] Installing Docker...${NC}"
ssh root@$DROPLET_IP 'curl -fsSL https://get.docker.com | sh && usermod -aG docker root'

# Step 3: Install Docker Compose
echo -e "${YELLOW}[3/7] Installing Docker Compose...${NC}"
ssh root@$DROPLET_IP 'curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose'

# Step 4: Clone Repository
echo -e "${YELLOW}[4/7] Cloning repository...${NC}"
ssh root@$DROPLET_IP 'mkdir -p /opt/97k && cd /opt/97k && git clone https://github.com/vik9541/97k-infrastructure.git . 2>/dev/null || git pull'

# Step 5: Setup Environment
echo -e "${YELLOW}[5/7] Setting up environment...${NC}"
ssh root@$DROPLET_IP '[ ! -f /opt/97k/.env ] && cat > /opt/97k/.env << "ENVFILE"
POSTGRES_USER=97k
POSTGRES_PASSWORD=change_me_in_production
POSTGRES_DB=97k_db
DATABASE_URL="postgresql://97k:change_me_in_production@postgres:5432/97k_db"
NODE_ENV="production"
PORT=3000
NEXT_PUBLIC_API_URL="https://97k.ru"
ENVFILE
'

# Step 6: Setup Firewall
echo -e "${YELLOW}[6/7] Configuring Firewall...${NC}"
ssh root@$DROPLET_IP 'ufw --force enable && ufw allow 22/tcp && ufw allow 80/tcp && ufw allow 443/tcp'

# Step 7: Start Services
echo -e "${YELLOW}[7/7] Starting services...${NC}"
ssh root@$DROPLET_IP 'cd /opt/97k && docker-compose down 2>/dev/null; docker-compose up -d'

sleep 5

echo ""
echo -e "${GREEN}=== Deployment Complete ===${NC}"
echo ""
echo "✓ Access points:"
echo -e "  Frontend: http://$DROPLET_IP:3001"
echo -e "  Backend:  http://$DROPLET_IP:3000"
echo ""
echo "Next: Update .env with secure passwords and configure SSL"
echo -e "${GREEN}Happy deploying! 🚀${NC}"
