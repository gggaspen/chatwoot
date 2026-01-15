# Local Development Setup - Chatwoot

## ✅ Setup Complete!

Your local development environment has been successfully configured with:

- **Redis**: Running locally on `redis://127.0.0.1:6379`
- **PostgreSQL 17**: Running locally with user `gggaspen`
- **Database**: `chatwoot_development` (created and migrated)

## 🚀 Quick Start

### Start Rails Console
```bash
bin/rails console
```

### Start Rails Server
```bash
bin/rails server
```

### Run Tests
```bash
bundle exec rspec
```

### Database Commands
```bash
# Create database
bin/rails db:create

# Run migrations
bin/rails db:migrate

# Rollback migration
bin/rails db:rollback

# Reset database (drop, create, migrate, seed)
bin/rails db:reset

# Seed database
bin/rails db:seed
```

## 📝 Environment Configuration

Your `.env` file contains:
```
REDIS_URL=redis://127.0.0.1:6379
DATABASE_URL=postgresql://gggaspen:password@localhost/chatwoot_development
SECRET_KEY_BASE=development_secret_key_replace_in_production
FRONTEND_URL=http://localhost:3000
```

## 🔧 Services Status

Check if services are running:

```bash
# Redis
redis-cli ping
# Should return: PONG

# PostgreSQL
sudo systemctl status postgresql
```

Start/stop services:
```bash
# Redis
sudo systemctl start redis-server
sudo systemctl stop redis-server

# PostgreSQL
sudo systemctl start postgresql
sudo systemctl stop postgresql
```

## 🐛 Troubleshooting

### Redis Connection Issues
If you get Redis connection errors:
```bash
sudo systemctl restart redis-server
redis-cli ping
```

### PostgreSQL Connection Issues
If you get database connection errors:
```bash
sudo systemctl restart postgresql
psql -U gggaspen -d chatwoot_development
```

### Migration Issues
If migrations fail:
```bash
bin/rails db:migrate:status  # Check migration status
bin/rails db:migrate         # Run pending migrations
```

## 📚 Additional Resources

- Chatwoot Documentation: https://www.chatwoot.com/docs
- Rails Guides: https://guides.rubyonrails.org
- PostgreSQL Documentation: https://www.postgresql.org/docs

## ⚠️ Important Notes

1. **Don't use `railway run` for local development** - it will try to connect to Railway's remote services
2. **Use `bin/rails console` directly** for local development
3. **Your PostgreSQL password is**: `password` (change this if deploying to production)
4. The `.env` file is for local development only and is gitignored

---

**Setup completed on**: 2026-01-14
