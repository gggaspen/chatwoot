#!/bin/bash
# Development environment startup script

echo "🚀 Starting Chatwoot Development Environment..."
echo ""

# Check if Redis is running
echo "📡 Checking Redis..."
if redis-cli ping > /dev/null 2>&1; then
    echo "✅ Redis is running"
else
    echo "⚠️  Redis is not running. Starting..."
    echo "12e12e12e" | sudo -S systemctl start redis-server
    if redis-cli ping > /dev/null 2>&1; then
        echo "✅ Redis started successfully"
    else
        echo "❌ Failed to start Redis"
        exit 1
    fi
fi

# Check if PostgreSQL is running
echo "📡 Checking PostgreSQL..."
if pg_isready -q; then
    echo "✅ PostgreSQL is running"
else
    echo "⚠️  PostgreSQL is not running. Starting..."
    echo "12e12e12e" | sudo -S systemctl start postgresql
    sleep 2
    if pg_isready -q; then
        echo "✅ PostgreSQL started successfully"
    else
        echo "❌ Failed to start PostgreSQL"
        exit 1
    fi
fi

echo ""
echo "✅ All services are running!"
echo ""
echo "You can now:"
echo "  • Start Rails console: bin/rails console"
echo "  • Start Rails server:  bin/rails server"
echo "  • Run tests:          bundle exec rspec"
echo ""
