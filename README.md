# macOS Vagrant Box

A clean (no other software installed or configured) macOS box. No changes made
to the box beyond those performed by [macinbox](https://github.com/bacongravy/macinbox).

*Use only in accordance with the Apple SLAs: https://www.apple.com/legal/sla/.*

These boxes are built for use with [VirtualBox](https://www.virtualbox.org/).

Defaults:

* 4 GB of memory
* 2 CPUs
* 64 GB dynamically-allocated disk
* APFS (Apple File System)
* username: `vagrant`
* password: `vagrant`

## macOS Catalina (10.15)

https://app.vagrantup.com/ramsey/boxes/macos-catalina

    vagrant box add ramsey/macos-catalina

## macOS Mojave (10.14)

https://app.vagrantup.com/ramsey/boxes/macos-mojave

    vagrant box add ramsey/macos-mojave

## macOS High Sierra (10.13)

https://app.vagrantup.com/ramsey/boxes/macos-high-sierra

    vagrant box add ramsey/macos-high-sierra

## FAQs

### How do I get started?

You can quickly start using `vagrant init [box name]`. For example:

    vagrant init ramsey/macos-catalina

### How do I SSH to the VM?

Use the `vagrant ssh` command.

### How can I launch the GUI to click around in the macOS VM?

Add the following to your Vagrantfile:

``` ruby
config.vm.provider "virtualbox" do |vb|
  vb.gui = true
end
```

If you've already started the VM, reload the configuration with
`vagrant reload`. VirtualBox will now launch the GUI, where you may log in
and click around.
