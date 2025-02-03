# MarkAI v1.0 Specification

*AI Instruction Markup, Inspired by Markdown and Built for Automation*

**Version:** 1.0\
**Date:** January 2025\
**License:** MIT

---

## **1. Introduction**

MarkAI is a lightweight, structured language designed for embedding AI instructions within human-readable Markdown documents. Its purpose is to enable automated workflows by providing a standardized syntax for defining and invoking commands. This specification formalizes the syntax, processing rules, and best practices that all MarkAI-compatible implementations must follow.

**MarkAI is a strict extension of Markdown.** Traditional Markdown renderers must **ignore** `@ai:` tags, ensuring that MarkAI-enhanced documents remain **fully readable** in non-AI environments.

MarkAI v1.0 introduces:

- **The `@ai:` tag format**.
- **Mandatory leading slashes for command invocations in define blocks** (e.g., `@ai:def /sync`).
- **Immutable commands** using `locked="true"` (when defined in a block).
- **Preemptive execution of high-priority commands** with `preempt="true"` (when defined in a block).
- **Auto-synchronization and structured logging** for AI-enhanced automation workflows.

**Important Note:** Every command invocation (using formats such as `@ai: /command`) **must** have a corresponding definition block. Simple invocations without a prior definition will be ignored. Future versions may support default or built-in command definitions for ad hoc usage, thereby reducing the need for explicit define blocks in every instance.

This specification defines these features and serves as the **definitive reference** for all MarkAI-compatible implementations.

## **2. Core Syntax**

MarkAI uses a structured tagging system in which all AI instructions begin with the prefix `@ai:`. Commands may be invoked or defined with specific attributes to control their behavior.

### **2.1. Basic Command Invocation**

A simple invocation is written as follows:
```plaintext
@ai: /sync
```
This line triggers the execution of the `/sync` command. **However, without a prior definition block for `/sync`, this invocation will be ignored.**

### **2.2. Human-Readable Annotations**

Commands can be accompanied by human-readable comments that are ignored by the AI processor. For example:
```plaintext
@ai: /format_json

<!--ai-ignore
  This section requires special formatting and is for human readers only.
ai-ignore-->
```
In this example, the AI executes the `/format_json` command (assuming it has a corresponding definition) and disregards the content within the ignore block.

### **2.3. Protected Commands (Immutable)**

Certain commands must remain immutable. To apply attributes such as `locked="true"`, you must define the command in a block.

**Simple Invocation Example (no attributes):**
```plaintext
@ai: /update_model
```

**Immutable Definition Example:**
```plaintext
@ai:def /update_model lock="true"
{
  // Command configuration details go here.
}
@ai:end
```
Once defined with `locked="true"`, the command cannot be modified by automated processes.

### **2.4. Including External Instructions**

External rule files can be integrated using the include directive:
```plaintext
@ai:include=".markairules.ma"
```
*Note:* Files must have the `.ma` extension. **Future enhancements may support version tags or namespaces (e.g., `rules.ma#v1.0`),** which will allow more sophisticated dependency management.

### **2.5. Preemptive Execution**

Commands that require immediate execution prior to other instructions must be defined with the `preempt="true"` attribute.

**Invocation Example:**
```plaintext
@ai: /consciousness
```

**Preemptive Definition Example:**
```plaintext
@ai:def /consciousness prio="true"
{
  // Preemptive command configuration details.
}
@ai:end
```
Commands defined with `preempt="true"` are executed before all other commands.

### **2.6. Structured Data Instructions**

MarkAI supports embedding structured JSON data within commands to supply configuration and parameters. All such blocks must be properly terminated with `@ai:end`.

**Setup Configuration Example:**
```plaintext
@ai:setup
{
  "version": "1.0",
  "description": "Embedding Markdown with AI instructions using structured JSON."
}
@ai:end
```

**Command Instruction Example:**
```plaintext
@ai:cmd
{
  "task": "create_blog_post",
  "topic": "The Importance of Open Standards in Technology",
  "requirements": {
    "structure": ["Introduction", "Main Discussion", "Conclusion"],
    "format": "Markdown",
    "tone": "professional and engaging",
    "include": [
      "at least one code block example",
      "a bullet list summarizing key points"
    ]
  }
}
@ai:end
```

### **2.7. Invocation vs. Definition**

- **Slash Commands (Invocation):**  
  Use the syntax `@ai: /command` to trigger execution. **Every such invocation must have an associated definition block elsewhere in the document.** If no definition exists, the command is disregarded.
  
  _Example:_
  ```plaintext
  @ai: /sync
  ```

- **Define Blocks (Definition):**  
  Use the syntax `@ai:def /command` ... `@ai:end` to specify detailed configuration and behavior. Once defined, the command may be invoked via its corresponding slash command.
  
  _Example:_
  ```plaintext
  @ai:def /sync locked="false" auto="true"
  {
    "action": "synchronize repository data",
    "destination": ".markai/LAST_SYNC.txt"
  }
  @ai:end
  ```

### **2.8. Dynamic Command Usage (Future Enhancement)**

While the current specification requires an explicit definition block for every command, **future versions of MarkAI may include default or built-in command definitions.** This would allow for ad hoc command invocations (without an explicit define block) while still maintaining backward compatibility.

### **2.9. Attribute Conflict Resolution**

When multiple attributes are applied to a command, the following order of precedence is enforced:

1. **`sec="ring0"`:**  
   - Highest precedence; commands with this attribute are immutable and safeguarded by strict security protocols.
2. **`lock="true"`:**  
   - Ensures that a command cannot be modified once defined.
3. **`prio="true"`:**  
   - Indicates that the command should be executed before others.
4. **`auto="true"`:**  
   - Enables automatic execution (e.g., for synchronization tasks).

**Combined Effects Example:**  
If a command is defined with both `lock="true"` and `prio="true"`, it will be executed before others and its configuration will be immutable. When `sec="ring0"` is also applied, that command is given the highest level of security and cannot be overridden or modified under any circumstances.

### **2.10. Instruction Syntax Guidelines**

- **Commands and Definitions:**  
  - All commands and their definitions **must** include a leading slash. For example, use `@ai: /command` in both invocation and definition blocks.
- **Non-Command Instructions:**  
  - Certain instructions (e.g., `@ai:setup` or `@ai:include`) do **not** require a leading slash.

## **3. Processing Rules**

1. **Command Execution Order:**  
   - Instructions are processed sequentially, except for those marked with `preempt="true"`, which execute before all others.
   
2. **Definition Requirement:**  
   - Every command invocation must have a corresponding definition block. Invocations without such definitions are ignored.

3. **Immutable and Secure Commands:**  
   - Commands defined with `locked="true"` are immutable.
   - Commands defined with `security="ring0"` are executed under elevated security measures and cannot be modified or unlocked.

4. **Auto-Synchronization:**  
   - The `/sync` command logs operations in `.markai/LAST_SYNC.txt`.
   - A minimum interval of 5 minutes is enforced between sync operations.
   - Commands defined with `auto="true"` run automatically.

5. **Human-Readable Comments:**  
   - Content within `<!--ai-ignore ... ai-ignore-->` blocks is disregarded during command processing.

6. **Error Handling Protocols:**  
   - **Detection:** The processor must detect errors such as missing `@ai:end` tags, malformed JSON blocks, and duplicate command definitions.
   - **Reporting:** All errors should be logged to `.markai/ERRORS.txt` with detailed context, including error type and line number where applicable.
   - **Recovery:** For syntax errors (e.g., a missing termination tag), the affected command should be skipped with an appropriate error log entry. In critical cases, automated recovery strategies (such as rolling back to the last valid state) may be executed.

## **4. Security & Compliance**

| **Attribute**      | **Effect**                                                 |
| ------------------ | ---------------------------------------------------------- |
| `sec="ring0"`      | The command is immutable and executes under heightened security protocols. |
| `lock="true"`      | The command cannot be modified once defined.             |
| `prio="true"`      | Indicates that the command should be executed before others. |
| `auto="true"`       | Enables auto-synchronization for the `/sync` command.      |

Additional security measures include:
- **Strict Logging:** All operations, especially those involving `security="ring0"`, must be logged in `.markai/SECURITY.txt` in JSON format.
- **Command Validation:** Commands are checked against a safety whitelist, and violations are flagged immediately.
- **Example:**  
  ```plaintext
  @ai:def /protect_data sec="ring0" lock="true"
  {
    // Sensitive data handling configuration.
  }
  @ai:end
  ```
  This command is safeguarded from modification and operates under the highest security protocols.

## **5. Versioning & Future Updates**

MarkAI follows Semantic Versioning (SemVer):
- **Patch (1.0.x):** Bug fixes and minor refinements.
- **Minor (1.x.0):** New features while maintaining backward compatibility.
- **Major (x.0.0):** Breaking changes and significant enhancements.

### **Deprecation and Obsolescence Guidelines**

- **Deprecation Strategy:**  
  When a command or attribute is considered obsolete, it will be marked as deprecated in the documentation and via warning logs (in `.markai/ERRORS.txt`) for one major version cycle before removal.
- **Backward Compatibility:**  
  Deprecated commands will continue to function for at least one subsequent major release to ensure smooth migration.
- **Documentation:**  
  Each deprecation will include alternative recommendations along with a timeline for removal.

Future updates shall maintain backward compatibility where feasible.

## **6. Tooling & Ecosystem**

MarkAI is designed for seamless integration with:
- AI-enhanced editors
- GitHub automation and CI/CD pipelines
- CLI tools for MarkAI file validation
- IDE plugins that provide syntax highlighting and real-time processing

These integrations aim to improve developer productivity while ensuring that AI instructions remain unambiguous and secure.

## **7. Best Practices for Writing MarkAI Documents**

- **Documentation:**  
  Use human-readable comments (`<!--ai-ignore ... ai-ignore-->`) to explain decisions, annotate special handling, or provide context.
  
- **Top-Level Placement:**  
  Place AI instructions at the beginning of the document for clear visibility.
  
- **Explicit Definitions:**  
  Ensure every command that is invoked has a corresponding definition block. Avoid relying on simple invocations without definitions.
  
- **Consistent Syntax:**  
  Adhere to the instruction syntax guidelines (leading slashes for commands, proper termination with `@ai:end`, etc.).
  
- **Cautious Attribute Use:**  
  Use attributes such as `preempt="true"`, `locked="true"`, and `security="ring0"` judiciously to maintain both flexibility and security.

## **8. Conclusion**

MarkAI revolutionizes AI-powered automation by combining human-readable Markdown with machine-executable instructions. This refactored specification provides clear, secure, and flexible guidelines for embedding AI instructions—a framework that is both scalable and maintainable. By adhering to these guidelines, developers ensure that AI instructions remain unambiguous, secure, and optimally integrated into modern development workflows.

MarkAI v1.0 is now the **official standard** for AI automation workflows.

---

### **References**

- **MarkAI v1.0 Specification:** [GitHub Repository](https://github.com/natehouk/markai)
- **License:** MIT License (© 2025 Nathaniel J. Houk)
