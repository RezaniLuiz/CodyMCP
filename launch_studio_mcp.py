import os
import subprocess
import sys

def _candidate_roots():
    roots = []
    local = os.environ.get("LOCALAPPDATA")
    if local:
        roots.append(os.path.join(local, "Roblox", "Versions"))
    program_files = os.environ.get("ProgramFiles(x86)") or os.environ.get("ProgramFiles")
    if program_files:
        roots.append(os.path.join(program_files, "Roblox", "Versions"))
    return roots


def find_studio_mcp():
    paired = []  
    orphans = []  
    for root in _candidate_roots():
        if not os.path.isdir(root):
            continue
        try:
            for entry in os.listdir(root):
                vdir = os.path.join(root, entry)
                exe = os.path.join(vdir, "StudioMCP.exe")
                if not os.path.isfile(exe):
                    continue
                if os.path.isfile(os.path.join(vdir, "RobloxStudioBeta.exe")):
                    paired.append(exe)
                else:
                    orphans.append(exe)
        except OSError:
            continue
    candidates = paired or orphans
    if not candidates:
        return None
    candidates.sort(key=lambda p: os.path.getmtime(p), reverse=True)
    return candidates[0]


def main():
    exe = find_studio_mcp()
    if not exe:
        sys.stderr.write(
            "launch_studio_mcp: no StudioMCP.exe found. Open Roblox Studio and "
            "enable 'Studio as MCP server' (Assistant Settings > MCP Servers).\n"
        )
        return 1
    sys.stderr.write(f"launch_studio_mcp: using {exe}\n")
    sys.stderr.flush()
    proc = subprocess.Popen([exe] + sys.argv[1:])
    try:
        return proc.wait()
    except KeyboardInterrupt:
        proc.terminate()
        return proc.wait()


if __name__ == "__main__":
    sys.exit(main())
