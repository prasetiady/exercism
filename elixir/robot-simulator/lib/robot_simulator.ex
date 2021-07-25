defmodule Robot do
  defstruct [:direction, :position]
end

defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})
  def create(:invalid, _), do: {:error, "invalid direction"}
  def create(0, _), do: {:error, "invalid direction"}

  def create(direction, _)
      when direction != :north and direction != :east and direction != :south and
             direction != :west,
      do: {:error, "invalid direction"}

  def create(_, {_, _, _}), do: {:error, "invalid position"}

  def create(_, {x, y}) when not is_number(x) or not is_number(y),
    do: {:error, "invalid position"}

  def create(_, position) when is_number(position), do: {:error, "invalid position"}
  def create(_, position) when is_bitstring(position), do: {:error, "invalid position"}
  def create(_, position) when is_list(position), do: {:error, "invalid position"}
  def create(_, position) when is_nil(position), do: {:error, "invalid position"}

  def create(direction, position) do
    %Robot{direction: direction, position: position}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, ""), do: robot

  def simulate(robot, instructions) do
    if String.match?(instructions, ~r/^[RLA]+$/) do
      instruction = String.first(instructions)

      %Robot{direction: direction, position: position} = robot

      {x, y} = position

      direction =
        cond do
          instruction == "R" && direction == :north -> :east
          instruction == "R" && direction == :east -> :south
          instruction == "R" && direction == :south -> :west
          instruction == "R" && direction == :west -> :north
          instruction == "L" && direction == :north -> :west
          instruction == "L" && direction == :east -> :north
          instruction == "L" && direction == :south -> :east
          instruction == "L" && direction == :west -> :south
          true -> direction
        end

      position =
        if instruction == "A" do
          cond do
            direction == :north -> {x, y + 1}
            direction == :east -> {x + 1, y}
            direction == :south -> {x, y - 1}
            direction == :west -> {x - 1, y}
            true -> position
          end
        else
          position
        end

      robot = %Robot{direction: direction, position: position}
      instructions = String.slice(instructions, 1..-1)
      simulate(robot, instructions)
    else
      {:error, "invalid instruction"}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    %Robot{direction: direction, position: _} = robot
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    %Robot{direction: _, position: position} = robot
    position
  end
end
