import { EOL } from "os";
import * as path from "path";
import * as core from "@actions/core";
import * as system from "./os";
import * as versions from "./swift-versions";
import * as macos from "./macos-install";
import * as linux from "./linux-install";
import * as windows from "./windows-install";
import { getVersion } from "./get-version";
import * as exec from "@actions/exec";

async function run() {
  try {
    const requestedVersion = core.getInput("swift-version", { required: true });

    let platform = await system.getSystem();
    let version = versions.verify(requestedVersion, platform);
    core.info("hello!");
    switch (platform.os) {
      case system.OS.MacOS:
        await macos.install(version, platform);
        break;
      case system.OS.Ubuntu:
        await linux.install(version, platform);
        break;
      case system.OS.Windows:
        await windows.install(version, platform);
    }

    const current = await getVersion();
    if (current === version) {
      core.setOutput("version", version);
    } else {
      core.error(
        `Failed to setup requested swift version. requestd: ${version}, actual: ${current}`
      );
    }

    // run `./run.sh` script file and print the output to as info
    const swiftFilePath = path.join(__dirname, "parser.swift");
    await exec.exec(`swift`, [swiftFilePath], {
      listeners: {
        stdout: (data: Buffer) => {
          core.info(data.toString());
        },
        stderr: (data: Buffer) => {
          core.info(data.toString());
        },
      },
    });

    // run `./run.sh` script file and print the output to as info
    const scriptPath = path.join(__dirname, "run.sh");
    await exec.exec(`sh`, [scriptPath], {
      listeners: {
        stdout: (data: Buffer) => {
          core.info(data.toString());
        },
        stderr: (data: Buffer) => {
          core.info(data.toString());
        },
      },
    });
  } catch (error) {
    let dump: String;
    if (error instanceof Error) {
      dump = `${error.message}${EOL}Stacktrace:${EOL}${error.stack}`;
    } else {
      dump = `${error}`;
    }

    core.setFailed(
      `Unexpected error, unable to continue. Please report at https://github.com/swift-actions/setup-swift/issues${EOL}${dump}`
    );
  }
}

run();
