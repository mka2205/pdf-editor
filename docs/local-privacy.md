# Desktop privacy review

Reviewed upstream commit `5cf56ee227fd1ef64582053170b52751b5a8b3c2` on November 23, 2026. The scope was the macOS desktop launch path, application source, project build configuration and the locked dependency advisory scan. The review found no code that automatically uploads the contents of an opened PDF to an AI service or telemetry endpoint. It did not audit every third-party dependency line by line.

| Finding | Behavior in this fork |
| --- | --- |
| The upstream desktop app checks for updates on startup. Release requests reveal connection metadata such as the IP address. | The desktop build skips startup checks and declines manual checks. The macOS launcher also blocks socket networking at the OS level. |
| Documents can request that the app open a URL, submit a form or print. | External browser handoff is disabled. The existing form submission handler displays a notice. The desktop print dialog offers local PDF output. Document JavaScript starts disabled on every launch. |
| Upstream provides a CLI agent server and an optional GUI control channel. | The launcher runs the desktop executable without a control endpoint. The CLI requires separate invocation. |
| In the browser build, an embedding host can receive the PDF bytes and file name when a user saves. | This is a separate build target. The macOS launcher runs the native desktop application. |
| `AGENTS.md`, `CLAUDE.md` and CodeRabbit configuration direct development tools. Some release and CI workflows called externally maintained workflows with access to configured secrets. | The original instructions and workflows are archived in `docs/upstream/`, outside their automatic discovery paths. No instruction to transmit personal files or credentials was found in the inspected text. |
| Recent filenames, preferences and crash-recovery copies can persist locally. | The launcher uses a private umask and portable storage under the ignored build directory. A cloud-synced destination or system service can still copy data outside the editor. |

## Dependency scan

The lockfile updates Tokio to 1.53.3 for its I/O safety advisory and replaces the withdrawn versions of async-executor and clipboard-win. The final RustSec scan reports one vulnerability and five unmaintained-package warnings. The vulnerability concerns private-key timing in `rsa 0.10.0-rc.18`. The native signing path uses AWS-LC for RSA private-key operations and the flagged crate for public-key verification. The advisory remains present in the lockfile. [RustSec RSA advisory](https://rustsec.org/advisories/RUSTSEC-2023-0071.html)

The maintenance warnings name chrono, proc-macro-error, zbus_names, zvariant and zvariant_derive. The scan covers the entire workspace lockfile, including other platforms and development dependencies. RustSec database revision `52384ab5581a4487b62c549eef95cf7ba7e8bad5` was used.
