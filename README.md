# GraphXR Lite

A lightweight graph visualization and analysis platform integrating GraphXR with modern graph databases.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Available Integrations](#available-integrations)
- [Project Structure](#project-structure)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

GraphXR Lite provides ready-to-use Docker stacks for graph visualization and analysis. Combine GraphXR's interactive interface with Neo4j, Memgraph, or PuppyGraph to quickly explore graph data.

## ✨ Features

- **One-Command Deployment** - Launch with `docker-compose up -d`
- **Multiple Databases** - Neo4j, Memgraph, or PuppyGraph
- **Sample Datasets** - Pre-configured examples included
- **Interactive Visualization** - GraphXR's powerful graph interface

## 🔌 Available Integrations

### Neo4j
GraphXR + Neo4j with Movie Graph example dataset.

**[📖 Setup Guide](./neo4j/README.md)**

- Popular graph database with Cypher query language
- Built-in Neo4j Browser interface
- Sample movie dataset included

### Memgraph
GraphXR + Memgraph for high-performance analytics.

**[📖 Setup Guide](./memgraph/README.md)**

- In-memory graph database for fast queries
- Memgraph Lab interface
- Game of Thrones example dataset

### PuppyGraph
GraphXR + PuppyGraph with Apache Iceberg integration.

**[📖 Setup Guide](./puppygraph/README.md)**

- Query engine over Iceberg data lakes
- Spark + MinIO stack included
- Cloud security graph demo dataset

## 📁 Project Structure

```
graphxr-lite/
├── README.md           # This file
├── neo4j/              # Neo4j integration
├── memgraph/           # Memgraph integration
└── puppygraph/         # PuppyGraph integration
```

## 📚 Documentation

- **[Neo4j Integration](./neo4j/README.md)** - Neo4j + GraphXR setup
- **[Memgraph Integration](./memgraph/README.md)** - Memgraph + GraphXR setup
- **[PuppyGraph Integration](./puppygraph/README.md)** - PuppyGraph + GraphXR setup

## 🤝 Contributing

Contributions welcome! Please open an issue before making major changes.

## 🔗 Related Resources

- [GraphXR Documentation](https://helpcenter.kineviz.com)
- [Neo4j Documentation](https://neo4j.com/docs/)
- [Memgraph Documentation](https://memgraph.com/docs)
- [PuppyGraph Documentation](https://docs.puppygraph.com/)
