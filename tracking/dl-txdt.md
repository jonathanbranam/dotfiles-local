+++
id = "dl-txdt"
title = "Opt-in migrations are pending in this project"
kind = "chore"
state = "pending"
created_at = "2026-11-14T12:05:25.092Z"
updated_at = "2026-11-14T12:05:25.344613166Z"
created_by = "human"
watchers = ["human"]
+++

These migrations are opt-in: bridle does not run them at start-up, because they rewrite this project's files and want a review first. Decide whether this project needs each one, and if so run it on the trial or integration branch and commit the result:

- 0002-standard-ticket-fields: Rename ticket frontmatter fields to the standard names and qualify ticket ids with the project prefix (ticket syqn).
- 0004-ticket-links-in-frontmatter: Carry the daemon's blocks, parent and related edges between tickets into their frontmatter and drop the `tasks:` list (ticket 3v75).
- 0005-a-ticket-for-every-active-task: Give every active task without a ticket a stub ticket, and every extra task of a ticket a child ticket, so each piece of work has one (ticket 72t9).

Run one with `bridle migrate --only <id>` (add --dry-run to see what it would change).

## Thread

### note · human · 2026-11-14T12:05:25.344Z
Opt-in migrations are pending in this project

These migrations are opt-in: bridle does not run them at start-up, because they rewrite this project's files and want a review first. Decide whether this project needs each one, and if so run it on the trial or integration branch and commit the result:

- 0002-standard-ticket-fields: Rename ticket frontmatter fields to the standard names and qualify ticket ids with the project prefix (ticket syqn).
- 0004-ticket-links-in-frontmatter: Carry the daemon's blocks, parent and related edges between tickets into their frontmatter and drop the `tasks:` list (ticket 3v75).
- 0005-a-ticket-for-every-active-task: Give every active task without a ticket a stub ticket, and every extra task of a ticket a child ticket, so each piece of work has one (ticket 72t9).

Run one with `bridle migrate --only <id>` (add --dry-run to see what it would change).
