defmodule Mix.Tasks.Hibou.Setup do
  @moduledoc false

  use Mix.Task

  def run([]) do
    run(["./"])
  end

  def run([path]) do
    IO.puts("🦉 configuring Hibou ...")
    info = find_info(path)
    IO.puts("Module name is: #{info.module_name}")
    IO.puts("Web Module name is: #{info.web_module_name}")
    IO.puts("App name is: #{info.app_name}")

    base_dir =
      case File.exists?(".is_dev") do
        true -> "."
        false -> "deps/hibou"
      end

    append(
      "#{base_dir}/phoenix/lib/my_app_web/router.ex",
      "#{path}/lib/#{info.web_app_name}/router.ex",
      info
    )

    append(
      "#{base_dir}/phoenix/config/config.exs",
      "#{path}/config/config.exs",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app/auth_access_pipeline.ex",
      "#{path}/lib/#{info.app_name}/auth_access_pipeline.ex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app/guardian.ex",
      "#{path}/lib/#{info.app_name}/guardian.ex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/controllers/authorization_controller.ex",
      "#{path}/lib/#{info.web_app_name}/controllers/authorization_controller.ex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/controllers/registration_controller.ex",
      "#{path}/lib/#{info.web_app_name}/controllers/registration_controller.ex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/controllers/session_controller.ex",
      "#{path}/lib/#{info.web_app_name}/controllers/session_controller.ex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/controllers/token_controller.ex",
      "#{path}/lib/#{info.web_app_name}/controllers/token_controller.ex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/templates/authorization/new.html.eex",
      "#{path}/lib/#{info.web_app_name}/templates/authorization/new.html.eex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/templates/registration/new.html.eex",
      "#{path}/lib/#{info.web_app_name}/templates/registration/new.html.eex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/templates/registration/created.html.eex",
      "#{path}/lib/#{info.web_app_name}/templates/registration/created.html.eex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/templates/session/new.html.eex",
      "#{path}/lib/#{info.web_app_name}/templates/session/new.html.eex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/views/authorization_view.ex",
      "#{path}/lib/#{info.web_app_name}/views/authorization_view.ex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/views/registration_view.ex",
      "#{path}/lib/#{info.web_app_name}/views/registration_view.ex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/lib/my_app_web/views/session_view.ex",
      "#{path}/lib/#{info.web_app_name}/views/session_view.ex",
      info
    )

    create_file(
      "#{base_dir}/phoenix/priv/repo/migrations/20180503022233_create_users.exs",
      "#{path}/priv/repo/migrations/20180503022233_create_users.exs",
      info
    )

    create_file(
      "#{base_dir}/phoenix/priv/repo/migrations/20180503062233_create_clients.exs",
      "#{path}/priv/repo/migrations/20180503062233_create_clients.exs",
      info
    )

    create_file(
      "#{base_dir}/phoenix/priv/repo/migrations/20180503042233_create_activation_code.exs",
      "#{path}/priv/repo/migrations/20180503042233_create_activation_code.exs",
      info
    )

    create_file(
      "#{base_dir}/phoenix/priv/repo/migrations/20180503092233_create_authorization.exs",
      "#{path}/priv/repo/migrations/20180503092233_create_authorization.exs",
      info
    )

    create_file(
      "#{base_dir}/phoenix/priv/repo/migrations/20180903052233_create_org.exs",
      "#{path}/priv/repo/migrations/20180903052233_create_org.exs",
      info
    )

    IO.puts("Done!")
  end

  def find_info(path) do
    lines = File.read!("#{path}/mix.exs") |> String.split("\n")

    module_name =
      List.first(lines)
      |> String.replace("defmodule ", "")
      # Phoenix 1.3
      |> String.replace(".Mixfile do", "")
      # Phoenix 1.4
      |> String.replace(".MixProject do", "")

    app_name =
      Regex.replace(~r/[A-Z]/, module_name, "_\\0") |> String.downcase() |> String.slice(1..-1)

    %{
      module_name: module_name,
      web_module_name: "#{module_name}Web",
      app_name: app_name,
      web_app_name: "#{app_name}_web"
    }
  end

  def create_file(source, dest, info) do
    File.mkdir_p(Path.dirname(dest))

    data =
      File.read!(source)
      |> replace_data(info)

    IO.puts("Generating #{dest}")

    File.write!(dest, data)
  end

  def append(source, dest, info) do
    [_ | raw_segments] = String.split(File.read!(source), "# append_start ")
    segments = parse_raw_segment(raw_segments, [], info)
    dest_content = File.read!(dest)
    dest_content = generate_merged_data(segments, dest_content, info)
    File.write!(dest, dest_content)
  end

  def generate_merged_data([segment | tail], dest_content, info) do
    [up, down] = String.split(dest_content, segment.options.after)
    start_warning = "# 🦉🦉🦉 Start of autogenerated content, feel free to update it 🦉🦉🦉\n"
    end_warning = "# 🦉🦉🦉 End of generated content 🦉🦉🦉 \n"

    new_content =
      case String.contains?(dest_content, segment.options.check_value) do
        true ->
          dest_content

        false ->
          Enum.join(
            [up, segment.options.after, "\n\n", start_warning, segment.data, end_warning, down],
            ""
          )
      end

    generate_merged_data(
      tail,
      new_content,
      info
    )
  end

  def generate_merged_data([], dest_content, _info) do
    dest_content
  end

  def replace_data(data, info) do
    data
    |> String.replace("MyApp", info.module_name)
    |> String.replace("my_app", info.app_name)
  end

  def parse_raw_segment([raw_segment | tail], segments, info) do
    [segment | _] = String.split(raw_segment, "# append_stop")
    [header | data] = segment |> String.split("\n")
    {options, _} = Code.eval_string(header)

    transformed_data =
      data
      |> Enum.join("\n")
      |> replace_data(info)

    parse_raw_segment(
      tail,
      segments ++
        [
          %{
            options: options,
            data: transformed_data
          }
        ],
      info
    )
  end

  def parse_raw_segment([], segments, _info) do
    segments
  end
end
