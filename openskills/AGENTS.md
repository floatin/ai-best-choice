# AGENTS

<skills_system priority="1">

## 可用技能

<!-- SKILLS_TABLE_START -->
<usage>
当用户要求您执行任务时，检查下面可用的技能是否可以帮助更有效地完成任务。技能提供专业能力和领域知识。

如何使用技能：
- 调用：`Bash("openskills read <技能名称>")`
- 技能内容将加载详细指令说明如何完成任务
- 输出中提供基础目录用于解析捆绑资源（references/、scripts/、assets/）

使用注意事项：
- 仅使用下面 `<available_skills>` 中列出的技能
- 不要调用已在您上下文中加载的技能
- 每个技能调用都是无状态的
</usage>

<available_skills>

<skill>
<name>frontend-design</name>
<description>创建具有高品质设计的独特、生产级前端界面。当用户要求构建网页组件、页面、工件、海报或应用程序时使用此技能（示例包括网站、着陆页、仪表板、React 组件、HTML/CSS 布局，或对任何 Web UI 进行样式美化）。生成富有创意、精致的代码和 UI 设计，避免通用的 AI 美学。</description>
<location>global</location>
</skill>

</available_skills>
<!-- SKILLS_TABLE_END -->

</skills_system>