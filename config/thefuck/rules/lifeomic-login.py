
MATCHES = [
    "An error occurred (ExpiredToken) when calling the AssumeRole operation",
    "Missing credentials in config, if using AWS_CONFIG_FILE, set AWS_SDK_LOAD_CONFIG=1",
]

def match(command):
    return any(match in command.output for match in MATCHES)

def get_new_command(command):
    return f'lifeomic-aws login --duration 28800; {command.script}'

# Optional:
enabled_by_default = True

priority = 1000  # Lower first, default is 1000

# requires_output = True
