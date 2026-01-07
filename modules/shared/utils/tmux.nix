{
  config,
  pkgs,
  ...
}: {
  config = {
    home-manager.users.${config.charly.user.name} = {
      programs.tmux = {
        enable = true;
        baseIndex = 1;
        prefix = "C-a";
        keyMode = "vi";
        plugins = with pkgs; [
          tmuxPlugins.catppuccin
        ];
        extraConfig = ''
          set -g detach-on-destroy off     # don't exit from tmux when closing a session
          set -g escape-time 0             # zero-out escape time delay
          set -g history-limit 1000000     # increase history size (from 2,000)
          set -g renumber-windows on       # renumber all windows when any window is closed
          set -g set-clipboard on          # use system clipboard
          set -g status-position top       # macOS / darwin style
          set -g pane-active-border-style 'fg=magenta,bg=default'
          set -g pane-border-style 'fg=brightblack,bg=default'

          set -g @catppuccin_flavor "macchiato"
          set -g @catppuccin_status_background "none"
          set -g @catppuccin_window_status_style "none"
          set -g @catppuccin_pane_status_enabled "off"
          set -g @catppuccin_pane_border_status "off"

          # status left look and feel
          set -g status-left-length 100
          set -g status-left ""
          set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_bg},bold]  #S },#{#[bg=#{@thm_bg},fg=#{@thm_green}]  #S }}"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_maroon}]  #{pane_current_command} "
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"

          # status right look and feel
          set -g status-right-length 100
          set -g status-right ""
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %H:%M "

          # Configure Tmux
          set -g status-position top
          set -g status-style "bg=#{@thm_bg}"
          set -g status-justify "absolute-centre"

          # pane border look and feel
          setw -g pane-border-status top
          setw -g pane-border-format ""
          setw -g pane-active-border-style "bg=#{@thm_bg},fg=#{@thm_overlay_0}"
          setw -g pane-border-style "bg=#{@thm_bg},fg=#{@thm_surface_0}"
          setw -g pane-border-lines single

          # window look and feel
          set -wg automatic-rename on
          set -g automatic-rename-format "Window"

          set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
          set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_rosewater}"
          set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_peach}"
          set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
          set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
          set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"

          set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
          set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"

          # Better pane navigation
          version_pat='s/^tmux[^0-9]*([.0-9]+).*/\1/p'

          is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
          bind-key -n M-h if-shell "$is_vim" "send-keys M-h" "select-pane -L"
          bind-key -n M-j if-shell "$is_vim" "send-keys M-j" "select-pane -D"
          bind-key -n M-k if-shell "$is_vim" "send-keys M-k" "select-pane -U"
          bind-key -n M-l if-shell "$is_vim" "send-keys M-l" "select-pane -R"

          if-shell -b '[ "$(tmux -V | cut -d" " -f2 | awk -F. "{print (\$1 >= 3)}")" = 1 ]' \
            "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\\\' 'select-pane -l'" \
              "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\' 'select-pane -l'"

          bind-key -T copy-mode-vi M-h select-pane -L
          bind-key -T copy-mode-vi M-j select-pane -D
          bind-key -T copy-mode-vi M-k select-pane -U
          bind-key -T copy-mode-vi M-l select-pane -R
          bind-key -T copy-mode-vi M-\\ select-pane -l
        '';
      };
    };
  };
}
