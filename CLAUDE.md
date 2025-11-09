# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Chinese-language educational repository containing tutorials, slides, talks, and examples about maximizing productivity with AI coding agents (Claude Code, GitHub Copilot, Cline, Codex, etc.). The project structure supports both documentation content and a small Python package.

## Development Commands

### Python Development
- **Run Python code**: Always use `pixi run python <script>` instead of system Python
- **Example**: `pixi run python -c "print('hello')"`
- **Run module**: `pixi run python -m code_them_all`
- **Environment info**: `pixi info`

The Python environment is managed by Pixi (not pip/venv). The package `code_them_all` is installed in editable mode via `pyproject.toml`.

### Slide Development (Slidev)
- **Dev server for intro slides**: `npm run slides:dev:intro`
- **Build intro slides**: `npm run slides:build:intro`
- **Build all slides**: `npm run slides:build:all`

Slides are located in `slides/` subdirectories with `slides.md` files.

### Optional Linting
- **Markdown lint**: `npx markdownlint "**/*.md"`
- **Link check**: `npx markdown-link-check -q README.md`

## Architecture

### Directory Structure

**Content Directories** (Chinese-language documentation):
- `tutorials/` - Long-form guides, one topic per file/folder
- `slides/` - Slidev presentations with source in `slides/*/slides.md`
- `talks/` - Speaker outlines, scripts, Q&A
- `examples/` - Runnable code snippets with READMEs
- `resources/` - Shared assets (images, reference materials)

**Context System** (`context/` directory):
The project uses a structured AI development context system:
- `context/design/` - Technical specs and architecture documents
- `context/hints/` - Operation guides and troubleshooting (e.g., `howto-*.md`)
- `context/instructions/` - Reusable prompt fragments and command templates
- `context/logs/` - Development session records
- `context/plans/` - Implementation roadmaps and strategies
- `context/refcode/` - Reference implementations (e.g., `slidev` submodule)
- `context/roles/` - Role-based system prompts
- `context/summaries/` - Knowledge base and analysis documents
- `context/tasks/` - Task management (subdirs: `working/`, `done/`, `backlog/`)

**Magic Context** (`magic-context/` directory):
Reusable prompt templates and AI interaction patterns for different coding scenarios:
- `magic-context/general/` - Universal prompts (Python coding guide, PyPI setup, mirror configs, etc.)
- `magic-context/blender-plugin/` - Blender-specific development prompts
- `magic-context/instructions/` - Task-specific templates (unit testing, refactoring, documentation, code review)
- `magic-context/mcp-dev/` - MCP server development guides
- `magic-context/speckit/` - Specification and implementation workflow templates
- `magic-context/scripts/` - Utility scripts (PDF/HTML to Markdown conversion)

**Configuration Directories**:
- `.claude/commands/` - Custom slash commands for Claude Code (mostly SpecKit workflow commands)
- `.codex/prompts/` - Prompts for Codex CLI (SpecKit commands mirrored here)
- `.specify/` - SpecKit configuration

**Python Package**:
- `src/code_them_all/` - Python package (minimal, editable install via Pixi)

### Key Patterns

1. **Context Document Headers**: All context documents should include:
   ```markdown
   ## HEADER
   - **Purpose**: Document purpose
   - **Status**: active/completed/deprecated/failed
   - **Date**: Creation or last update
   - **Dependencies**: Related requirements
   - **Target**: Target audience (AI assistant, developer, etc.)
   ```

2. **SpecKit Workflow**: The project uses custom slash commands for structured development:
   - `/speckit.specify` - Create/update feature specifications
   - `/speckit.plan` - Execute implementation planning
   - `/speckit.tasks` - Generate dependency-ordered tasks
   - `/speckit.implement` - Execute implementation plan
   - `/speckit.clarify` - Identify underspecified areas
   - `/speckit.analyze` - Cross-artifact consistency analysis
   - `/speckit.checklist` - Generate custom checklists
   - `/speckit.constitution` - Project constitution management

3. **Naming Conventions**:
   - Logs: `YYYY-MM-DD_feature-name-implementation-success.md`
   - Hints: `howto-setup-development-environment.md`
   - Tasks: Clear descriptive names in appropriate status folder

## Language and Localization

- **Primary language**: Chinese (Simplified) for all documentation, tutorials, and slides
- **Preserve Chinese terminology**: Do not auto-translate Chinese content
- **Commit messages**: Write in Chinese, use imperative style with prefixes like `docs:`, `tutorials:`, `slides:`, `examples:`, `fix:`, `chore:`

## Code Style

### Markdown
- **Filenames**: lowercase-kebab-case (e.g., `getting-started.md`, `image-name.png`)
- **Format**: Use `#`-based headings, fenced code blocks with language tags
- **Line length**: Aim for ≤100 characters
- **Links**: Relative paths within repo, descriptive alt text for images
- **Assets**: Place shared assets in `resources/`, directory-local images in nested `images/` folders

### Python
The project follows strict Python coding conventions detailed in `magic-context/general/python-coding-guide.md`:

**Class Design Patterns**:
- **Member variables**: Prefix with `m_` (e.g., `self.m_data`, `self.m_config`)
  - Exception: Do NOT use `m_` for data models (`@attrs.define` or `pydantic.BaseModel`)
- **Constructors**: Take no arguments; initialize all members to `None`
- **Factory methods**: Use `@classmethod` with `cls.from_xxx()` pattern for object creation
- **Properties**: Read-only via `@property` decorator (no setters)
- **Setters**: Explicit `set_xxx()` methods with validation

**Type Annotations**:
- Use `typing` module with full type hints on all functions/methods
- Use `Optional[T]` for nullable types, `TypeVar` for generic classes
- Annotate all parameters and return values

**Documentation**:
- NumPy-style docstrings for all modules, classes, functions
- Include Parameters, Returns, Raises, Examples sections
- Module-level docstrings listing Classes and Functions

**Example**:
```python
from typing import Optional, Type, TypeVar

T = TypeVar('T', bound='MyClass')

class MyClass:
    def __init__(self) -> None:
        self.m_data: Optional[str] = None

    @property
    def data(self) -> Optional[str]:
        return self.m_data

    def set_data(self, value: str) -> None:
        self.m_data = value

    @classmethod
    def from_file(cls: Type[T], path: str) -> T:
        instance = cls()
        instance.set_data(Path(path).read_text())
        return instance
```

## Development Guidelines

1. **Minimal diffs**: Keep edits scoped to relevant folders
2. **No unnecessary restructuring**: Do not reformat unrelated files
3. **Update READMEs**: When adding content, update the corresponding folder README and root README if broadly relevant
4. **No secrets**: Use placeholders like `<API_KEY>` in examples
5. **Validate examples**: Ensure code blocks are runnable or mark as pseudo-code
6. **Check links**: Lint Markdown and validate links before committing

## Reference Documentation

For detailed guides on specific topics, see:
- Python coding standards: `magic-context/general/python-coding-guide.md`
- MCP server development: `magic-context/mcp-dev/mcp-server-development-guide.md`
- Pixi integration: `magic-context/general/howto-pyproject-pixi-integration.md`
- Context directory structure: `context/README.md`
- SpecKit workflows: `magic-context/speckit/README.md`
