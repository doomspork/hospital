defmodule Hospital.HostView do
  use Hospital.Web, :view

  def render("index.json", %{hosts: hosts}) do
    %{data: render_many(hosts, Hospital.HostView, "host.json")}
  end

  def render("show.json", %{host: host}) do
    %{data: render_one(host, Hospital.HostView, "host.json")}
  end

  def render("host.json", %{host: host}) do
    %{id: host.id,
      address: host.address}
  end
end
