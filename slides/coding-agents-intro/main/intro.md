# 简介：编码代理发展脉络（按时间顺序）

1. Chatbot 普及化（2022）
   - 以 ChatGPT 为代表（2022/11 公测），将“在对话中写代码/解释代码”带入大众视野，提高了自然语言编程的可用性。
   - 参考：OpenAI ChatGPT 发布（概述，2022/11）
     - https://pmc.ncbi.nlm.nih.gov/articles/PMC10337400/

2. GitHub Copilot 技术预览（2021）→ 商业化（2022）
   - 2021/06 技术预览上线；随后集成到 VS Code、JetBrains 等主流 IDE，成为“AI 结对编程”的标配形态。
   - 参考：
     - 技术预览新闻（2021/06）：https://thehackernews.com/2021/06/github-launches-copilot-ai-powered-code.html
     - Wiki 概览：https://en.wikipedia.org/wiki/GitHub_Copilot

3. Cursor（2023 起）
   - 基于 VS Code 生态的 AI IDE，主打指令式改写、对话式协作与项目级上下文，逐步走向“编辑器即代理”的形态。
   - 参考：
     - Wiki（背景/公司信息）：https://en.wikipedia.org/wiki/Cursor_(code_editor)

4. Cline（2024–2025）
   - 开源的 VS Code 自主编码代理扩展，支持计划/编辑/命令执行/浏览器等多工具，强调“按步骤获批”的安全工作流与 MCP 集成。
   - 参考：
     - GitHub Releases：https://github.com/cline/cline/releases
     - 官网 FAQ：https://cline.bot/faq

5. Claude Code（2024–2025）
   - Anthropic 推出的编码体验，将 Claude 的“工具调用（终端/文件编辑等）”用于真实工程流，覆盖编辑、运行与调试。
   - 参考：
     - 产品页：https://claude.com/product/claude-code

6. Codex CLI（2025）
   - OpenAI 开源的本地终端编码代理（openai/codex），强调安全沙箱与权限模型，适合在版本库中进行自动化改动。
   - 参考：
     - GitHub：https://github.com/openai/codex
     - 开发者文档：https://developers.openai.com/codex/cli/

小结：
- 从“聊天式代码辅助”到“IDE/终端内的自主代理”，工具逐步具备读取/修改/运行代码与联网能力；
- 兼顾“安全可控”（权限/沙箱）与“复杂任务自动化”，成为提升工程效率的新范式。
