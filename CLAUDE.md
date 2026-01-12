# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Chatwoot is an open-source customer support platform (alternative to Intercom/Zendesk). It's a Rails 7.1 + Vue 3 application with Ruby 3.4.4, Node 23.x, and pnpm 10.x.

## Essential Commands

### Development Server
```bash
# Start all services (Rails, Sidekiq, Vite)
pnpm run dev          # Uses overmind
# OR
pnpm run start:dev    # Uses foreman
```

### Testing
```bash
# Ruby tests (RSpec)
bundle exec rspec                           # Run all specs
bundle exec rspec spec/path/to/file_spec.rb # Run single file
bundle exec rspec spec/path/to/file_spec.rb:42  # Run specific line

# JavaScript tests (Vitest)
pnpm test                    # Run all tests once
pnpm test:watch              # Watch mode
pnpm test:coverage           # With coverage
```

### Linting
```bash
# Ruby
bundle exec rubocop
bundle exec rubocop -a       # Auto-fix

# JavaScript/Vue
pnpm run eslint
pnpm run eslint:fix
```

### Database
```bash
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
```

## Architecture

### Backend (Rails)

**Core Models** (`app/models/`):
- `Account` - Multi-tenant parent; most models belong to an account
- `User` - Agents/administrators
- `Contact` - End customers
- `Inbox` - Communication channels (web widget, email, WhatsApp, etc.)
- `Conversation` - Customer interactions within an inbox
- `Message` - Individual messages in conversations
- `Channel::*` - Channel-specific implementations (WebWidget, Email, Whatsapp, Telegram, etc.)

**API Structure** (`app/controllers/api/`):
- `v1/accounts/*` - Account-scoped resources (conversations, contacts, inboxes)
- `v1/widget/*` - Public widget endpoints
- `v2/accounts/*` - Newer report/analytics endpoints

**Background Jobs** (`app/jobs/`): Sidekiq-based async processing for webhooks, notifications, channel message delivery.

**Services** (`app/services/`): Business logic extraction, organized by domain (auto_assignment, conversations, messages, channels).

### Frontend (Vue 3)

**Dashboard** (`app/javascript/dashboard/`):
- `api/` - API client wrappers
- `store/` - Vuex modules for state management
- `components/` - Reusable Vue components
- `views/` - Page-level components
- `i18n/` - Internationalization files

**Widget** (`app/javascript/widget/`): Embeddable customer-facing chat widget.

**Key Patterns**:
- Vuex for global state
- Pinia used for newer stores (captain features)
- Vue Router for navigation
- Tailwind CSS for styling

### Enterprise Features

The `enterprise/` directory contains proprietary features:
- Captain (AI assistant)
- SAML SSO
- SLA policies
- Custom roles
- Voice channels
- Companies (contact grouping)

Enterprise code extends core models/controllers via Ruby's `prepend` pattern.

### Real-time Communication

ActionCable channels (`app/channels/`) handle WebSocket connections for:
- Live conversation updates
- Typing indicators
- Agent presence

## Branching Model

Uses git-flow: `develop` is the base branch for PRs. `master` contains stable releases.

## Key Configuration Files

- `config/sidekiq.yml` - Background job queues
- `config/routes.rb` - API and web routes
- `.rubocop.yml` - Ruby style (max line length: 150)
- `.eslintrc.js` - Vue/JS style with vue-i18n rules

## Style Notes

**Vue Components**:
- Script block order: `<script>`, `<template>`, `<style>`
- Use `vue/no-bare-strings-in-template` - all strings must be i18n keys
- PascalCase for component names

**Ruby**:
- HashSyntax: `never` use shorthand (`{ key: key }` not `{ key: }`)
- Compact style for class/module children
