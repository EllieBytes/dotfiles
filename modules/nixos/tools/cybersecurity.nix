{ myLib, pkgs, lib, config, ... }:

myLib.registerModule "tools/cybersecurity" {
  # Packages...
  config.environment.systemPackages = with pkgs; [
    thc-hydra nmap wireshark wireshark-cli wireshark-qt tshark metasploit wifite2 gobuster aircrack-ng bloodhound sqlmap
    powershell dirb sherlock ffuf whatweb netcat hashcat cowpatty hping nikto autopsy responder crunch macchanger
    ettercap amass john subfinder snort dnschef steghide spider reaverwps reaverwps-t6x netexec mimikatz dnsenum bettercap
    dirstalk dirbuster tcpdump mitm6 burpsuite netdiscover gemini-cli fierce dnsrecon
    dmitry cewl yara nuclei evil-winrm caido bully bed arjun arjun-cnf websploit stegseek
    smtp-user-enum medusa masscan hash-identifier feroxbuster eyewitness chirp cadaver assetfinder arp-scan arping armitage
    airgeddon wfuzz wapiti wafw00f testdisk sslscan spike socat setools
  ];
}
