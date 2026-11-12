# 10 Essential Linux Terminal Tricks & Shortcuts

**Source:** [10 Linux Tricks I WISH I Knew Sooner (In 9 Minutes)](https://youtu.be/JjnICN3yW4E) by **StackMonsters**

This guide summarizes 10 practical Bash shortcuts and commands that work out-of-the-box on almost every Linux distribution (including Ubuntu) to save time and reduce repetitive typing.

---

## 1. Search Your Command History (`Ctrl + R`)
Instead of pressing the `Up` arrow repeatedly to find an old command, use reverse-i-search.
* **Shortcut:** `Ctrl + R`
* **How it works:** Press `Ctrl + R` and start typing any part of a previous command. Press `Ctrl + R` again to cycle backward through older matches, `Enter` to run it immediately, or `Right Arrow` / `Esc` to place it on your prompt for editing.

---

## 2. Rerun the Last Command as Root (`sudo !!`)
Forgot to type `sudo` before running a command that requires root privileges? You don't need to retype the whole command.
* **Command:**
  ```bash
  sudo !!
  ```
* **How it works:** `!!` (bang-bang) expands to the entire previous command. Running `sudo !!` executes that exact command with elevated privileges.

---

## 3. Reuse the Last Argument (`Alt + .` or `$_`)
Quickly grab the last argument (such as a long file path or directory name) from your previous command.
* **Shortcut:** `Alt + .` (or `Esc` followed by `.`)
* **Alternative Variable:** `$_`
* **Example:**
  ```bash
  mkdir -p /var/www/html/my-new-project
  cd <press Alt + .>   # Expands to: cd /var/www/html/my-new-project
  ```
* *Tip:* Pressing `Alt + .` repeatedly cycles backward through the last arguments of earlier commands.

---

## 4. Jump Back to the Previous Directory (`cd -`)
Toggle effortlessly between your current working directory and the last directory you were in.
* **Command:**
  ```bash
  cd -
  ```
* **How it works:** Functions like a "Back" button in the terminal, printing the path you switched back to.

---

## 5. Edit Command Lines Fast (`Ctrl + A`, `Ctrl + E`, `Ctrl + W`)
Stop holding down the `Left` or `Right` arrow keys to navigate long commands.
* **`Ctrl + A`:** Jump the cursor to the **beginning** of the line.
* **`Ctrl + E`:** Jump the cursor to the **end** of the line.
* **`Ctrl + W`:** Delete the **word** immediately before the cursor.

---

## 6. Append to Root-Owned Files (`sudo tee -a`)
Standard output redirection (`sudo echo "text" >> /etc/file`) fails with a "Permission denied" error because the shell handles the redirection (`>>`) before `sudo` elevates privileges.
* **Command:**
  ```bash
  echo "127.0.0.1 myapp.local" | sudo tee -a /etc/hosts
  ```
* **How it works:** `tee` reads from standard input and writes to both standard output and files as `sudo`. The `-a` flag ensures it **appends** rather than overwrites the file. *(Tip: Add `> /dev/null` at the end if you don't want the text echoed back to your screen).*

---

## 7. Create or Delete Multiple Files at Once (Brace Expansion)
Use curly braces `{}` to generate arbitrary strings or sequences without writing a loop.
* **Examples:**
  ```bash
  # Create multiple numbered files at once
  touch file{1..5}.txt

  # Create a project folder structure in one command
  mkdir -p project/{src,docs,tests}

  # Quickly back up a configuration file
  cp /etc/nginx/nginx.conf{,.bak}
  ```

---

## 8. Park a Half-Typed Command (`Ctrl + U` and `Ctrl + Y`)
If you are halfway through typing a long command and realize you need to run something else first, you don't have to delete your work.
* **`Ctrl + U`:** Cuts everything from the cursor back to the start of the line and stores it in the terminal's kill-ring (clipboard).
* **`Ctrl + Y`:** Pastes ("yanks") the cut command back onto the prompt once you are ready to finish it.

---

## 9. Pause and Resume Programs (`Ctrl + Z`, `jobs`, `fg`)
Temporarily suspend a foreground application (like a text editor or long-running script) to run other terminal commands, then bring it right back.
* **`Ctrl + Z`:** Pauses (suspends) the active foreground process and returns you to the shell prompt.
* **`jobs`:** Lists all suspended or background jobs along with their job numbers.
* **`fg`:** Brings the most recently suspended job back to the foreground (or use `fg %1` for a specific job number).

---

## 10. Create Custom Shortcuts (`alias` & `~/.bashrc`)
Turn long, frequently used commands or flag combinations into short, memorable keywords.
* **Temporary Alias (current session only):**
  ```bash
  alias ll='ls -lah'
  ```
* **Permanent Alias:**
  Add your aliases to `~/.bashrc` (or `~/.zshrc` if using Zsh) and reload the configuration:
  ```bash
  echo "alias ll='ls -lah'" >> ~/.bashrc
  echo "alias update='sudo apt update && sudo apt upgrade -y'" >> ~/.bashrc
  source ~/.bashrc
  ```

---

## Quick Reference Cheat Sheet

| Shortcut / Command | Action |
| :--- | :--- |
| `Ctrl + R` | Search command history interactively |
| `sudo !!` | Re-run the previous command with `sudo` |
| `Alt + .` | Insert the last argument from the previous command |
| `cd -` | Switch back to the previous directory |
| `Ctrl + A` / `Ctrl + E` | Move cursor to start / end of the line |
| `Ctrl + W` | Delete the word before the cursor |
| `... \| sudo tee -a <file>` | Append text to a root-owned file |
| `{a,b,c}` / `{1..5}` | Expand multiple arguments or ranges |
| `Ctrl + U` / `Ctrl + Y` | Cut (park) current line / Paste (restore) line |
| `Ctrl + Z` / `fg` | Pause active program / Resume program in foreground |
| `alias name='command'` | Create a custom command shortcut |