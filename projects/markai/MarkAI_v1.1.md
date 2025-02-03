# MarkAI v1.1 Specification

*AI Instruction Markup with Remote Execution Support*

**Version:** 1.1\
**Date:** February 2025\
**License:** MIT

---

## **1. Introduction**

MarkAI v1.1 builds upon **MarkAI v1.0**, adding **remote execution capabilities** while maintaining its core principle: embedding **AI-executable instructions** inside **human-readable Markdown**. The new version introduces:

- **Remote API Execution**: Define structured API endpoints to receive and process MarkAI commands remotely.
- **Security & Authentication**: Ensure secure execution of remote instructions.
- **Event Hooks & Middleware Support**: Route commands to internal handlers, log events, or trigger remote actions.
- **Backward Compatibility**: Existing MarkAI v1.0 documents remain fully functional.

This document formalizes the syntax, processing rules, and best practices for all MarkAI v1.1-compliant implementations.

---

## **2. Core Syntax Updates**

MarkAI v1.1 retains the `@ai:` directive structure but extends it with **remote execution attributes**.

### **2.1. Defining Remote API Commands**

New syntax allows remote API execution by defining an endpoint within an `@ai:def` block:

```plaintext
@ai:def /submit_command endpoint="https://api.example.com/execute" method="POST" auth="token"
{
  "command": "sync",
  "parameters": { "force": true }
}
@ai:end
```

**Key Attributes:**
- `endpoint`: The remote API URL.
- `method`: HTTP method (GET, POST, PUT, DELETE).
- `auth`: Authentication mechanism (e.g., `token`, `apikey`, `oauth`).

### **2.2. Invoking Remote Commands**

Once defined, remote commands can be invoked like local commands:

```plaintext
@ai: /submit_command
```

This triggers an HTTP request to the specified `endpoint`, sending the defined payload.

### **2.3. Secure Execution and Authentication**

Security is critical for remote execution. Supported authentication methods:
- `token="my_secret_token"`
- `apikey="my_api_key"`
- `oauth="access_token"`

Example:
```plaintext
@ai:def /fetch_data endpoint="https://api.example.com/data" method="GET" auth="apikey"
{
  "headers": { "Authorization": "Bearer my_api_key" }
}
@ai:end
```

### **2.4. Handling Responses**

Remote execution supports response handling using structured logging:

```plaintext
@ai:def /log_response
{
  "log_file": ".markai/RESPONSES.txt",
  "format": "json"
}
@ai:end
```

When a remote command executes, responses are logged in the defined format.

---

## **3. Middleware & Event Hooks**

### **3.1. Pre-Execution Hooks**
Plugins can modify commands before execution:

```python
def pre_process(commands):
    for cmd in commands:
        if cmd["command"] == "/sync":
            cmd["attributes"]["force"] = True  # Modify parameters
    return commands
```

### **3.2. Post-Execution Hooks**
Execute actions after command processing:

```python
def post_process(commands):
    log_results(commands, output_file=".markai/EXECUTION_LOGS.txt")
```

---

## **4. Security & Compliance**

| **Attribute**      | **Effect**  |
|------------------|------------------------------------------------|
| `sec="ring0"`   | Immutable execution under strict security protocols. |
| `lock="true"`   | Prevents modification after definition. |
| `prio="true"`   | Executes before standard commands. |
| `auto="true"`   | Enables scheduled execution. |

### **4.1. Secure Remote Execution Guidelines**
- All API calls **must** use HTTPS.
- Authentication **must** be included (tokens, API keys, OAuth, etc.).
- Command execution **must** be logged.
- Commands flagged with `sec="ring0"` require manual review.

---

## **5. Versioning & Backward Compatibility**

MarkAI v1.1 remains backward-compatible with v1.0. Existing `.ma` documents will continue functioning **without modification**.

**New Features in v1.1:**
- Remote API execution (`endpoint`, `method`, `auth`).
- Response handling (`log_file`, `format`).
- Middleware event hooks (`pre_process`, `post_process`).

Future versions (v1.2+) may introduce additional networked automation capabilities.

