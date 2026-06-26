[中文](#华杨-CMDB--社区版) | [English](#huayung-cmdb--community-edition) 

# 华杨 CMDB · 社区版

**🆓 企业级配置管理数据库，社区版永久免费！**

华杨 CMDB 是华杨智能运维平台的核心模块，可独立部署，用于统一纳管 IT 资产、应用及其依赖关系，帮助团队精准掌控基础设施，提升运维效率。

---

## ⚡ 快速开始

### 前置要求
1. **Docker Engine**: 需安装 Docker CE 29.4.0 及以上版本，并内置 docker compose 插件 
1. **端口占用**：确保 `4443` 端口未被其他服务占用
2. **防火墙**：如需远程访问，请确保防火墙开放 `4443` 端口
3. **资源要求**：建议至少 8核CPU 和 16GB 内存和 100GB 可用磁盘空间


### 一键部署
```bash
# 克隆仓库
git clone https://github.com/hyo-tech/CMDB.git
cd CMDB

# 启动服务
./scripts/install.sh <host_FQDN>
```

服务启动后，访问 `https://<host_FQDN>:4443/ui/100000001` (默认用户名密码 admin/admin), 即可开始使用。

> 详细配置说明请参考 [社区版部署指南](https://www.huayung.cn/docs/1.x/installation/installation-demo)。

---

## 🧐 为什么选择华杨CMDB？

### 🤖 AI原生
内置多个智能体对接大语言模型，用户可用自然语言使用产品能力并分析数据，大幅降低使用门槛，加速价值实现。

### 🧬 基于继承的配置项模型
预置200余种开箱即用类型，支持多级继承，子类型自动继承父类型全部属性与关系。存储开销最高降低40%，查询性能显著提升。

### 🎨 可视化画布构建拓扑
通过拖拽式画布直观定义依赖、连接与包含关系，实时预览拓扑。构建时间减少60%-70%，在影响生产前即可发现逻辑问题。

### 🕸️ 拓扑查询语言（TQL）
自研图数据查询语言，支持跨类型、跨关系的复杂拓扑检索。语法直观易用，基于自研图算法，深度增加时性能依然稳定。

### 🔎 自动发现引擎
基于IP段灵活配置，隔离网段可通过代理自动发现。持续扫描物理、虚拟、云及应用环境，构建实时感知的智能资源图谱。

### 🫆 智能识别引擎
通过可配置匹配逻辑实现唯一性识别，支持多源数据归一化与智能仲裁，自动合并去重，确保CMDB始终为唯一可信基准。

下载详细[产品介绍](https://www.huayung.cn/assets/files/%E5%8D%8E%E6%9D%A8CMDB%E4%BA%A7%E5%93%81%E4%BB%8B%E7%BB%8D.pdf)。

---

## 🔖 版本对比

| 功能 | 社区版 | 企业版 |
|---|---|---|
| 所有CMDB核心功能 | ✅ | ✅ |
| 高可用与集群部署 | ❌ | ✅ |
| 多租户 | ❌ | ✅ |
| 企业级技术支持 | ❌ | ✅ |

[联系我们](https://www.huayung.cn/index.html#form5-1m)了解如何购买企业版。

---

## ⚖️ 许可说明

本社区版软件的使用受 [LICENSE](https://github.com/hyo-tech/CMDB?tab=License-1-ov-file) 文件中的条款约束。

---

# Huayung CMDB · Community Edition

**🆓 Enterprise-grade configuration management database — Community Edition is permanently free!**

Huayung CMDB is the core module of the Huayung Smart Operations Platform. It can be deployed independently to centrally manage IT assets, applications, and their dependencies, helping teams gain precise visibility into their infrastructure and improve operational efficiency.

---

## ⚡ Quick Start

### Prerequisites
1. Docker Engine: Docker CE version 29.4.0 or higher is required, with the built-in Docker Compose plugin.
2. Port Availability: Ensure that port 4443 is not occupied by other services.
3. Firewall: If remote access is required, make sure port 4443 is open in the firewall.
4. Resource Requirements: It is recommended to have at least an 8-core CPU, 16GB of RAM, and 100GB of available disk space.

### One-Click Deployment
```bash
# Clone the repository
git clone https://github.com/hyo-tech/CMDB.git
cd CMDB

# Start the service
./scripts/install.sh <host_FQDN>
```

Once the service is running, access it at `https://<host_FQDN>:4443/ui/100000001` to get started.

> For detailed configuration, refer to the [Community Edition Deployment Guide](https://www.huayung.cn/docs/en/1.x/installation/installation-demo).

---

## 🧐 Why Huayang CMDB?

### 🤖 AI-Native
Built-in multiple agents that integrate with large language models. Users can interact with the platform and analyze data using natural language, significantly lowering the learning curve and accelerating time-to-value.

### 🧬 Inheritance-Based Configuration Item Model
Comes with 200+ pre-built configuration item types out of the box. Supports multi-level inheritance — subtypes automatically inherit all attributes and relationships from parent types. Reduces storage overhead by up to 40% with significantly improved query performance.

### 🎨 Visual Canvas for Building Topologies
Intuitively define dependencies, connections, and containment relationships using a drag-and-drop canvas with real-time topology preview. Reduces topology construction time by 60–70%, and helps catch logical issues before they impact production.

### 🕸️ Topology Query Language (TQL)
A self-developed graph query language designed for CMDB scenarios. Supports complex topological searches across types and relationships. The syntax is intuitive and easy to use; based on our proprietary graph algorithms, performance remains stable even as relationship depth increases.

### 🔎 Auto-Discovery Engine
Flexibly configurable by IP ranges; isolated network segments can be discovered via proxy agents. Continuously scans physical, virtual, cloud, and application environments to build a real-time resource map — not just a static asset inventory.

### 🫆 Intelligent Identification Engine
Ensures unique identification of configuration items through configurable matching and verfication rules. Supports data normalization and arbitration from multiple sources, with automatic deduplication and merging — keeping your CMDB as the single source of truth.

Download the full [Product Brochure](https://www.huayung.cn/en/assets/files/Huayung_CMDB_Intro.pdf).

---

## 🔖 Edition Comparison

| Feature | Community Edition | Enterprise Edition |
|---|---|---|
| All CMDB Core Features | ✅ | ✅ |
| High Availability & Cluster Deployment | ❌ | ✅ |
| Multi-Tenancy | ❌ | ✅ |
| Enterprise-Grade Technical Support | ❌ | ✅ |

[Contact us](https://www.huayung.cn/en/index.html#form5-1m) to learn more about purchasing the Enterprise Edition.

---

## ⚖️ License

Use of this Community Edition software is subject to the terms and conditions in the [LICENSE](https://github.com/hyo-tech/CMDB?tab=License-1-ov-file) file.
