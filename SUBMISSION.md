# Submission handoff

## Prepared source

- Intended public repository: `jtraverso/mycielski`.
- Source project directory: repository root.
- Metadata: `formalization.yaml` (upstream v0.4 schema validated).
- Comparator configuration: `comparator.json` (eight theorems, no definition holes).
- Local sandboxed Comparator, Lean and NanoDa checks: passed.
- GitHub CI: `.github/workflows/lean.yml`.
- Full Palomar mechanical preflight: `.github/workflows/palomar-preflight.yml`.

Read `README.md`, `VERIFICATION.md` and the recorded verification logs for scope
and evidence. This repository contains the substantive development.

## Publication and submission sequence

1. Create the public repository and publish the complete source. Identify the
   full 40-character public commit. Do not substitute a branch name or a local
   commit that has not been uploaded.
2. Dispatch the Palomar preflight workflow against that exact commit and inspect
   its outcome. The workflow is pinned to PalomarSubmission commit
   `c02bbeaed888df45c4e28c4e99dba540ad21552a`. It does not register a submission.
3. Read the current agent protocol at
   <https://submit.palomar-registry.org/llms.txt> before the first intake request.
   The current discovery document is
   <https://github.com/PalomarRegistry/PalomarWeb/blob/main/llms.txt> and the
   submission policy is
   <https://github.com/PalomarRegistry/PalomarPolicy/blob/main/CONTRIBUTING.md>.
4. Use the documented agent intake, temporary verification tag and secret gist
   to prove access. Declare the human maintainer's authorization, and keep all
   bearer tokens outside the repository and chat. Delete temporary proofs after
   successful authentication as the protocol directs.
5. Follow the submission through mechanical verification and private editorial
   review. Address any blocking findings before claiming eligibility.
6. Show the actual review to the author and explain permanent publication.
   The published agent protocol requires an explicit instruction after that
   disclosure before calling the registration endpoint with the review hash.
7. Verify the final public record and its exact commit. Only then add the actual
   Palomar identifier and permalink to any catalogue or documentation.

The author's instruction in this chat authorizes publication and submission.
No Palomar intake request or registry entry has yet been created.

## Access blockers observed on 2026-10-23

- The connected GitHub plugin supplies repository-file and Git-object writes,
  but no repository-creation operation. `jtraverso/mycielski` returned 404.
- The shell's configured `GH_TOKEN` failed `gh auth status` as invalid.
- The environment's restricted network policy rejects
  `submit.palomar-registry.org` with HTTP 403. `api.github.com`,
  `data.palomar-registry.org` and `gist.github.com` are also absent from its
  allowed-host list.

Publication needs an existing accessible repository or a valid GitHub CLI
credential with repository-creation access. Agent submission additionally needs
access to the Palomar submission service and the documented GitHub tag/gist
operations. Never paste a credential into chat or commit it to this repository.
