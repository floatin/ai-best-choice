# OpenSpec 指令

为使用OpenSpec进行规范驱动开发的AI编码助手提供的说明。

## 快速检查清单

- 搜索现有工作：`openspec spec list --long`、`openspec list`（全文搜索仅使用 `rg`）
- 确定范围：新功能 vs 修改现有功能
- 选择唯一的 `change-id`：kebab-case格式，动词开头（`add-`、`update-`、`remove-`、`refactor-`）
- 搭建框架：`proposal.md`、`tasks.md`、`design.md`（仅在需要时）、以及每个受影响功能的增量规范
- 编写增量：使用 `## ADDED|MODIFIED|REMOVED|RENAMED Requirements`；每个需求至少包含一个 `#### Scenario:`
- 验证：`openspec validate [change-id] --strict` 并修复问题
- 请求批准：在提案获得批准前不要开始实施

## 三阶段工作流程

### 第一阶段：创建变更

当出现以下情况时创建提案：
- 添加特性或功能
- 进行破坏性变更（API、架构）
- 改变架构或模式
- 优化性能（改变行为）
- 更新安全模式

触发条件（示例）：
- "帮我创建一个变更提案"
- "帮我规划一个变更"
- "帮我创建一个提案"
- "我想创建一个规范提案"
- "我想创建一个规范"

宽松匹配指导：
- 包含其中之一：`proposal`、`change`、`spec`
- 配合其中之一：`create`、`plan`、`make`、`start`、`help`

跳过提案的情况：
- Bug修复（恢复预期行为）
- 拼写错误、格式化、注释
- 依赖更新（非破坏性）
- 配置变更
- 现有行为的测试

**工作流程**
1. 查看 `openspec/project.md`、`openspec list` 和 `openspec list --specs` 以了解当前上下文
2. 选择唯一的动词开头 `change-id`，在 `openspec/changes/<id>/` 下搭建 `proposal.md`、`tasks.md`、可选的 `design.md` 和规范增量
3. 使用 `## ADDED|MODIFIED|REMOVED Requirements` 起草规范增量，每个需求至少包含一个 `#### Scenario:`
4. 运行 `openspec validate <id> --strict` 并在分享提案前解决任何问题

### 第二阶段：实施变更

将这些步骤作为TODO跟踪并逐一完成。
1. **阅读 proposal.md** - 理解要构建的内容
2. **阅读 design.md**（如果存在）- 审查技术决策
3. **阅读 tasks.md** - 获取实施清单
4. **按顺序实施任务** - 按顺序完成
5. **确认完成** - 确保所有 `tasks.md` 项目都完成后才更新状态
6. **更新清单** - 所有工作完成后，将每个任务设为 `- [x]` 以反映实际情况
7. **批准门控** - 在提案被审查和批准前不要开始实施

### 第三阶段：归档变更

部署后，创建单独的PR来：
- 移动 `changes/[name]/` → `changes/archive/YYYY-MM-DD-[name]/`
- 如果功能发生变化则更新 `specs/`
- 对仅工具变更使用 `openspec archive <change-id> --skip-specs --yes`（始终显式传递变更ID）
- 运行 `openspec validate --strict` 确认归档的变更通过检查

## 执行任何任务前的准备

**上下文检查清单：**
- [ ] 阅读 `specs/[capability]/spec.md` 中的相关规范
- [ ] 检查 `changes/` 中的待处理变更是否有冲突
- [ ] 阅读 `openspec/project.md` 了解约定
- [ ] 运行 `openspec list` 查看活跃变更
- [ ] 运行 `openspec list --specs` 查看现有功能

**创建规范前：**
- 始终检查功能是否已存在
- 优先修改现有规范而非创建重复项
- 使用 `openspec show [spec]` 审查当前状态
- 如果请求模糊，在搭建框架前询问1-2个澄清问题

### 搜索指导
- 列举规范：`openspec spec list --long`（或 `--json` 用于脚本）
- 列举变更：`openspec list`（或 `openspec change list --json` - 已弃用但可用）
- 显示详情：
  - 规范：`openspec show <spec-id> --type spec`（使用 `--json` 进行过滤）
  - 变更：`openspec show <change-id> --json --deltas-only`
- 全文搜索（使用ripgrep）：`rg -n "Requirement:|Scenario:" openspec/specs`

## 快速开始

### CLI命令

```bash
# 基本命令
openspec list                  # 列出活跃变更
openspec list --specs          # 列出规范
openspec show [item]           # 显示变更或规范
openspec validate [item]       # 验证变更或规范
openspec archive <change-id> [--yes|-y]   # 部署后归档（非交互运行添加 --yes）

# 项目管理
openspec init [path]           # 初始化OpenSpec
openspec update [path]         # 更新指令文件

# 交互模式
openspec show                  # 提示选择
openspec validate              # 批量验证模式

# 调试
openspec show [change] --json --deltas-only
openspec validate [change] --strict
```

### 命令标志

- `--json` - 机器可读输出
- `--type change|spec` - 消除项目歧义
- `--strict` - 全面验证
- `--no-interactive` - 禁用提示
- `--skip-specs` - 归档时不更新规范
- `--yes`/`-y` - 跳过确认提示（非交互归档）

## 目录结构

```
openspec/
├── project.md              # 项目约定
├── specs/                  # 当前真相 - 已构建的内容
│   └── [capability]/       # 单一专注的功能
│       ├── spec.md         # 需求和场景
│       └── design.md       # 技术模式
├── changes/                # 提案 - 应变更的内容
│   ├── [change-name]/
│   │   ├── proposal.md     # 原因、内容、影响
│   │   ├── tasks.md        # 实施清单
│   │   ├── design.md       # 技术决策（可选；见标准）
│   │   └── specs/          # 增量变更
│   │       └── [capability]/
│   │           └── spec.md # ADDED/MODIFIED/REMOVED
│   └── archive/            # 已完成变更
```

## 创建变更提案

### 决策树

```
新请求？
├─ Bug修复恢复规范行为？ → 直接修复
├─ 拼写/格式/注释？ → 直接修复  
├─ 新特性/功能？ → 创建提案
├─ 破坏性变更？ → 创建提案
├─ 架构变更？ → 创建提案
└─ 不明确？ → 创建提案（更安全）
```

### 提案结构

1. **创建目录：** `changes/[change-id]/`（kebab-case格式，动词开头，唯一）

2. **编写 proposal.md：**
```markdown
# 变更：[变更的简要描述]

## 原因
[关于问题/机会的1-2句话]

## 变更内容
- [变更项目符号列表]
- [用**BREAKING**标记破坏性变更]

## 影响
- 受影响的规范：[列出功能]
- 受影响的代码：[关键文件/系统]
```

3. **创建规范增量：** `specs/[capability]/spec.md`
```markdown
## 新增需求
### 需求：新功能
系统应当提供...

#### 场景：成功案例
- **当** 用户执行操作时
- **那么** 期望结果

## 修改需求
### 需求：现有功能
[完整的修改后需求]

## 移除需求
### 需求：旧功能
**原因**：[为什么移除]
**迁移**：[如何处理]
```
如果多个功能受影响，在 `changes/[change-id]/specs/<capability>/spec.md` 下为每个功能创建多个增量文件——每个功能一个。

4. **创建 tasks.md：**
```markdown
## 1. 实施
- [ ] 1.1 创建数据库架构
- [ ] 1.2 实现API端点
- [ ] 1.3 添加前端组件
- [ ] 1.4 编写测试
```

5. **需要时创建 design.md：**
如果出现以下任何情况则创建 `design.md`；否则省略：
- 跨领域变更（多服务/模块）或新架构模式
- 新外部依赖或重大数据模型变更
- 安全、性能或迁移复杂性
- 编码前受益于技术决策的模糊性

最小 `design.md` 骨架：
```markdown
## 上下文
[背景、约束、利益相关者]

## 目标/非目标
- 目标：[...]
- 非目标：[...]

## 决策
- 决策：[什么和为何]
- 考虑的替代方案：[选项+理由]

## 风险/权衡
- [风险] → 缓解措施

## 迁移计划
[步骤、回滚]

## 开放问题
- [...]
```

## 规范文件格式

### 关键：场景格式化

**正确**（使用####标题）：
```markdown
#### 场景：用户登录成功
- **当** 提供有效凭据时
- **那么** 返回JWT令牌
```

**错误**（不要使用项目符号或粗体）：
```markdown
- **场景：用户登录**  ❌
**场景**：用户登录     ❌
### 场景：用户登录      ❌
```

每个需求必须至少有一个场景。

### 需求措辞
- 对规范性需求使用SHALL/MUST（除非有意非规范，否则避免should/may）

### 增量操作

- `## ADDED Requirements` - 新功能
- `## MODIFIED Requirements` - 改变的行为
- `## REMOVED Requirements` - 弃用功能
- `## RENAMED Requirements` - 名称变更

标题与 `trim(header)` 匹配 - 忽略空白。

#### 何时使用ADDED vs MODIFIED
- ADDED：引入可以独立作为需求的新功能或子功能。当变更是正交的时优先使用ADDED（例如，添加"斜杠命令配置"）而不是改变现有需求的语义。
- MODIFIED：改变现有需求的行为、范围或接受标准。始终粘贴完整、更新的需求内容（标题+所有场景）。归档器将用你在此处提供的内容替换整个需求；部分增量将丢失之前的细节。
- RENAMED：仅当名称改变时使用。如果你也改变行为，使用RENAMED（名称）加上MODIFIED（内容）引用新名称。

常见陷阱：使用MODIFIED在不包含之前文本的情况下添加新关注点。这在归档时导致细节丢失。如果你没有明确改变现有需求，请在ADDED下添加新需求。

正确编写MODIFIED需求：
1) 在 `openspec/specs/<capability>/spec.md` 中定位现有需求
2) 复制整个需求块（从 `### 需求：...` 通过其场景）
3) 将其粘贴到 `## MODIFIED Requirements` 下并编辑以反映新行为
4) 确保标题文本完全匹配（空白不敏感）并保持至少一个 `#### 场景：`

RENAMED示例：
```markdown
## 重命名需求
- 从：`### 需求：登录`
- 到：`### 需求：用户认证`
```

## 故障排除

### 常见错误

**"变更必须至少有一个增量"**
- 检查 `changes/[name]/specs/` 是否存在.md文件
- 验证文件有操作前缀（## ADDED Requirements）

**"需求必须至少有一个场景"**
- 检查场景使用 `#### 场景：` 格式（4个井号）
- 不要对项目符号或粗体使用场景标题

**静默场景解析失败**
- 精确格式要求：`#### 场景：名称`
- 用以下方式调试：`openspec show [change] --json --deltas-only`

### 验证技巧

```bash
# 始终使用严格模式进行全面检查
openspec validate [change] --strict

# 调试增量解析
openspec show [change] --json | jq '.deltas'

# 检查特定需求
openspec show [spec] --json -r 1
```

## 理想路径脚本

```bash
# 1) 探索当前状态
openspec spec list --long
openspec list
# 可选全文搜索：
# rg -n "Requirement:|Scenario:" openspec/specs
# rg -n "^#|Requirement:" openspec/changes

# 2) 选择变更ID并搭建框架
CHANGE=add-two-factor-auth
mkdir -p openspec/changes/$CHANGE/{specs/auth}
printf "## 原因\n...\n\n## 变更内容\n- ...\n\n## 影响\n- ...\n" > openspec/changes/$CHANGE/proposal.md
printf "## 1. 实施\n- [ ] 1.1 ...\n" > openspec/changes/$CHANGE/tasks.md

# 3) 添加增量（示例）
cat > openspec/changes/$CHANGE/specs/auth/spec.md << 'EOF'
## 新增需求
### 需求：双因素认证
用户在登录时必须提供第二因子。

#### 场景：需要OTP
- **当** 提供有效凭据时
- **那么** 需要OTP挑战
EOF

# 4) 验证
openspec validate $CHANGE --strict
```

## 多功能示例

```
opencspec/changes/add-2fa-notify/
├── proposal.md
├── tasks.md
└── specs/
    ├── auth/
    │   └── spec.md   # 新增：双因素认证
    └── notifications/
        └── spec.md   # 新增：OTP邮件通知
```

auth/spec.md
```markdown
## 新增需求
### 需求：双因素认证
...
```

notifications/spec.md
```markdown
## 新增需求
### 需求：OTP邮件通知
...
```

## 最佳实践

### 简单性优先
- 默认少于100行新代码
- 单文件实施直到证明不足
- 无明确理由避免框架
- 选择无聊、经过验证的模式

### 复杂性触发
仅在以下情况下添加复杂性：
- 性能数据显示当前解决方案太慢
- 具体规模要求（>1000用户，>100MB数据）
- 多个已证明用例需要抽象

### 清晰引用
- 使用 `file.ts:42` 格式表示代码位置
- 引用规范为 `specs/auth/spec.md`
- 链接相关变更和PR

### 功能命名
- 使用动词-名词：`user-auth`、`payment-capture`
- 每个功能单一目的
- 10分钟可理解性规则
- 如果描述需要"和"则拆分

### 变更ID命名
- 使用kebab-case，简短描述性：`add-two-factor-auth`
- 优先动词开头前缀：`add-`、`update-`、`remove-`、`refactor-`
- 确保唯一性；如果被占用，追加 `-2`、`-3` 等

## 工具选择指南

| 任务 | 工具 | 原因 |
|------|------|------|
| 按模式查找文件 | Glob | 快速模式匹配 |
| 搜索代码内容 | Grep | 优化的正则搜索 |
| 读取特定文件 | Read | 直接文件访问 |
| 探索未知范围 | Task | 多步调查 |

## 错误恢复

### 变更冲突
1. 运行 `openspec list` 查看活跃变更
2. 检查重叠规范
3. 与变更所有者协调
4. 考虑合并提案

### 验证失败
1. 用 `--strict` 标志运行
2. 检查JSON输出获取详情
3. 验证规范文件格式
4. 确保场景正确格式化

### 缺少上下文
1. 首先阅读project.md
2. 检查相关规范
3. 审查最近归档
4. 请求澄清

## 快速参考

### 阶段指示器
- `changes/` - 已提议，尚未构建
- `specs/` - 已构建和部署
- `archive/` - 已完成变更

### 文件用途
- `proposal.md` - 原因和内容
- `tasks.md` - 实施步骤
- `design.md` - 技术决策
- `spec.md` - 需求和行为

### CLI要点
```bash
openspec list              # 进展如何？
openspec show [item]       # 查看详情
openspec validate --strict # 是否正确？
openspec archive <change-id> [--yes|-y]  # 标记为完成（自动化添加 --yes）
```

记住：规范是真相。变更是提案。保持它们同步。