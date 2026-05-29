# Skills

Fat skills, thin harness. Procedures live here; posture lives in `AGENTS.md`.

Each skill is a folder with a `SKILL.md` at the root. The agent reads `SKILL.md` when invoking the skill.

## Registry

<!-- One line per skill: name → when to use → path -->

_No skills yet. Add the first one by creating `skills/<your-skill>/SKILL.md`._

## Adding a skill

1. Create `skills/<your-skill>/SKILL.md`.
2. Add frontmatter: `name`, `description`, `when_to_use`.
3. Write a short purpose section, expected inputs/outputs, and a numbered playbook.
4. Add a verification step the agent can actually run.
5. Register the skill in this README under "Registry".

## Conventions

- **One responsibility per skill.** If a skill grows past ~150 lines or starts branching across unrelated workflows, split it.
- **Self-contained.** A skill should be readable without context from the rest of the project. Reference repo docs or other skills by name when needed.
- **Verifiable.** Every skill ends with a verification step the agent can actually run.
- **Idempotent where possible.** Running a skill twice should not break things.
