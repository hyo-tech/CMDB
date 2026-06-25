[中文](#中文) | [English](#english) 
## 中文
# 华杨 CMDB · 社区版

**🆓 企业级配置管理数据库，社区版永久免费！**

华杨 CMDB 是华杨智能运维平台的核心模块，可独立部署，用于统一纳管 IT 资产、应用及其依赖关系，帮助团队精准掌控基础设施，提升运维效率。

---

## ⚡ 快速开始

### 前置要求
- Docker 20.10+
- Docker Compose 2.0+

### 一键部署
```bash
# 克隆仓库
git clone https://github.com/你的组织名/your-cmdb-repo.git
cd your-cmdb-repo

# 启动服务
docker compose up -d
```

服务启动后，访问 `https://<host_FQDN>:4443/ui/100000001` 即可开始使用。

> 详细配置说明请参考 [社区版部署指南](https://www.huayung.cn/docs/1.x/installation/installation-demo)。

---

## 🧐 华杨CMDB有什么不一样？

### 🧬 配置项类型模型继承
支持配置项类型的多级继承，子类型自动继承父类型的全部属性与关系定义，大幅减少重复配置工作，确保模型定义的一致性与可维护性。

### 🎨 可视化画布构建关联关系
通过拖拽式画布直观定义配置项类型之间的依赖、连接与包含关系，实时预览关系拓扑，让复杂模型的构建像画流程图一样简单。

### 🕸️ 拓扑查询语言（TQL）
专为CMDB场景设计的灵活查询语言，支持跨类型、跨关系的复杂拓扑检索，一次查询即可获得配置项及其关联路径的完整信息，满足各类运维分析场景。

---

## 🧩 主要功能

| 模块 | 能力说明 |
|---|---|
| **仪表盘** | 可视化展示关键配置项指标，支持自定义面板 |
| **配置项目录** | 按模型类型层次浏览配置项数据，查看拓扑结构、跟踪变更历史 |
| **配置项列表** | 自定义列表视图，灵活按需求组织数据 |
| **配置项类型** | 基于继承架构的模型管理，自由扩展自定义类型，自定义属性、识别规则和关联关系 |
| **配置项关系类型** | 定义类型间的关系与约束，支持可视化画布配置 |
| **查询工作室** | 可视化构建TQL查询用于复杂拓扑检索，支持多种应用场景 |
| **选项列表** | 为属性提供预定义值 |

完整产品文档，请参考[华杨智能运维平台文档](https://www.huayung.cn/docs/1.x/intro)。

---

## 🔖 版本对比

| 功能 | 社区版 | 商业版 |
|---|---|---|
| 所有CMDB核心功能 | ✅ | ✅ |
| 高可用与集群部署 | ❌ | ✅ |
| 企业级技术支持 | ❌ | ✅ |

[联系我们了解更多](https://www.huayung.cn/index.html#form5-1m)。

---

## ⚖️ 许可说明

本社区版软件的使用受 [LICENSE](https://github.com/hyo-tech/CMDB?tab=License-1-ov-file) 文件中的条款约束。

---
## English
# Huayung CMDB · Community Edition

**🆓 Enterprise-grade configuration management database — Community Edition is permanently free!**

Huayung CMDB is the core module of the Huayung Smart Operations Platform. It can be deployed independently to centrally manage IT assets, applications, and their dependencies, helping teams gain precise visibility into their infrastructure and improve operational efficiency.

---

## ⚡ Quick Start

### Prerequisites
- Docker 20.10+
- Docker Compose 2.0+

### One-Click Deployment
```bash
# Clone the repository
git clone https://github.com/your-org/your-cmdb-repo.git
cd your-cmdb-repo

# Start the service
docker compose up -d
```

Once the service is running, access it at `https://<host_FQDN>:4443/ui/100000001` to get started.

> For detailed configuration, refer to the [Community Edition Deployment Guide](https://www.huayung.cn/docs/en/1.x/installation/installation-demo).

---

## 🧐 What Makes Huayung CMDB Different?

### 🧬 Configuration Item Type Model Inheritance
Supports multi-level inheritance for configuration item types. Subtypes automatically inherit all attributes and relationship definitions from their parent types, significantly reducing repetitive configuration work and ensuring consistency and maintainability across your model definitions.

### 🎨 Visual Canvas for Building Relationships
Intuitively define dependencies, connections, and containment relationships between configuration item types using a drag-and-drop canvas. Preview relationship topologies in real time — building complex models becomes as easy as drawing a flowchart.

### 🕸️ Topology Query Language (TQL)
A flexible query language purpose-built for CMDB scenarios. Supports complex topological searches across types and relationships. A single query returns complete information about configuration items and their associated paths, addressing a wide range of operational analysis needs.

---

## 🧩 Key Features

| Module | Description |
|---|---|
| **Dashboard** | Visualizes key configuration item metrics with support for custom panels |
| **Configuration Item Catalog** | Browse configuration item data by model type hierarchy, view topological structures, and track change history |
| **Configuration Item Lists** | Create custom list views to flexibly organize data according to your needs |
| **Configuration Item Types** | Model management based on an inheritance architecture — freely extend custom types, define custom attributes, identification rules, and relationships |
| **Configuration Item Relationship Types** | Define relationships and constraints between types with visual canvas configuration support |
| **Query Workbench** | Visually build TQL queries for complex topological searches across multiple use cases |
| **Option Lists** | Provide predefined values for attributes |

For complete product documentation, refer to the [Huayung Smart Operations Platform Documentation](https://www.huayung.cn/docs/en/1.x/intro).

---

## 🔖 Edition Comparison

| Feature | Community Edition | Enterprise Edition |
|---|---|---|
| All CMDB Core Features | ✅ | ✅ |
| High Availability & Cluster Deployment | ❌ | ✅ |
| Enterprise-Grade Technical Support | ❌ | ✅ |

[Contact us to learn more]((https://www.huayung.cn/en/index.html#form5-1m)).

---

## ⚖️ License

Use of this Community Edition software is subject to the terms and conditions in the [LICENSE](https://github.com/hyo-tech/CMDB?tab=License-1-ov-file) file.
