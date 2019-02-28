include:
  - .installed
  - .running


Configure salt minion:
  file.managed:
    - name: /etc/salt/minion.d/99-metalk8s.conf
    - source: salt://metalk8s/salt/minion/files/minion_99-metalk8s.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - backup: false
    - defaults:
      master_hostname: localhost
    - watch_in:
      - cmd: Restart salt-minion