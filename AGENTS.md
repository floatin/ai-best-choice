# OpenSpec 指令

这些指令是为在这个项目中工作的 AI 助手准备的。

当请求涉及以下内容时，始终打开 [`@/openspec/AGENTS.md`](openspec/AGENTS.md)：
- 提及规划或提案（如 proposal、spec、change、plan 等词汇）
- 引入新功能、破坏性变更、架构转变或重大性能/安全工作
- 听起来模糊，需要在编码前获取权威规范

使用 [`@/openspec/AGENTS.md`](openspec/AGENTS.md) 来了解：
- 如何创建和应用变更提案
- 规范格式和约定
- 项目结构和指南

保留这个受管理的块，以便 'openspec update' 可以刷新指令。

<!-- OPENSPEC:END -->

# OpenSkills 指令

<skills_system priority="1">

## Available Skills

<!-- SKILLS_TABLE_START -->
<usage>
When users ask you to perform tasks, check if any of the available skills below can help complete the task more effectively. Skills provide specialized capabilities and domain knowledge.

How to use skills:
- Invoke: Bash("openskills read <skill-name>")
- The skill content will load with detailed instructions on how to complete the task
- Base directory provided in output for resolving bundled resources (references/, scripts/, assets/)

Usage notes:
- Only use skills listed in <available_skills> below
- Do not invoke a skill that is already loaded in your context
- Each skill invocation is stateless
</usage>

<available_skills>

<skill>
<name>sdd-sync</name>
<description>规范驱动开发 (SDD) 与双仓 (Gitea/GitHub) 同步管家。当用户需要初始化项目、开始新功能开发、进行高频本地存档 (Checkpoint)、或在 GitHub 合并后同步本地状态时，此技能提供严格的 Git 工作流指导。它确保 Spec 领先于代码，且 GitHub 历史记录保持整洁。</description>
<location>project</location>
</skill>

<skill>
<name>frontend-design</name>
<description>Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, artifacts, posters, or applications (examples include websites, landing pages, dashboards, React components, HTML/CSS layouts, or when styling/beautifying any web UI). Generates creative, polished code and UI design that avoids generic AI aesthetics.</description>
<location>global</location>
</skill>

</available_skills>
<!-- SKILLS_TABLE_END -->

</skills_system>
