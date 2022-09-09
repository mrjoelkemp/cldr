# Generated from lib/cldr/language_tag/rfc5646_parser.ex.exs, do not edit.
# Generated at 2022-09-07 23:08:21Z.

defmodule Cldr.Rfc5646.Parser do
  @moduledoc """
  Implements parsing for [RFC5646](https://datatracker.ietf.org/doc/html/rfc5646) language
  tags with [BCP47](https://tools.ietf.org/search/bcp47) extensions.

  The primary interface to this module is the function
  `Cldr.LanguageTag.parse/1`.

  """

  alias Cldr.LanguageTag

  import Cldr.Rfc5646.Helpers

  def parse(rule \\ :language_tag, input) when is_atom(rule) and is_binary(input) do
    apply(__MODULE__, rule, [input])
    |> unwrap
  end

  defp unwrap({:ok, acc, "", _, _, _}) when is_list(acc),
    do: {:ok, acc}

  defp unwrap({:ok, _parsed, rest, _, _, offset}) do
    {:error,
     {LanguageTag.ParseError,
      "Could not parse the remaining #{inspect(rest)} starting at position #{offset + 1}"}}
  end

  defp unwrap({:error, <<first::binary-size(1), reason::binary>>, rest, _, _, offset}) do
    {:error,
     {LanguageTag.ParseError,
      "#{String.capitalize(first)}#{reason}. Could not parse the remaining #{inspect(rest)} " <>
        "starting at position #{offset + 1}"}}
  end

  @doc """
  Parses the given `binary` as extensions_and_private_use.

  Returns `{:ok, [token], rest, context, position, byte_offset}` or
  `{:error, reason, rest, context, line, byte_offset}` where `position`
  describes the location of the extensions_and_private_use (start position) as `{line, offset_to_start_of_line}`.

  To column where the error occurred can be inferred from `byte_offset - offset_to_start_of_line`.

  ## Options

    * `:byte_offset` - the byte offset for the whole binary, defaults to 0
    * `:line` - the line and the byte offset into that line, defaults to `{1, byte_offset}`
    * `:context` - the initial context value. It will be converted to a map

  """
  @spec extensions_and_private_use(binary, keyword) ::
          {:ok, [term], rest, context, line, byte_offset}
          | {:error, reason, rest, context, line, byte_offset}
        when line: {pos_integer, byte_offset},
             byte_offset: pos_integer,
             rest: binary,
             reason: String.t(),
             context: map
  def extensions_and_private_use(binary, opts \\ []) when is_binary(binary) do
    context = Map.new(Keyword.get(opts, :context, []))
    byte_offset = Keyword.get(opts, :byte_offset, 0)

    line =
      case Keyword.get(opts, :line, 1) do
        {_, _} = line -> line
        line -> {line, byte_offset}
      end

    case extensions_and_private_use__0(binary, [], [], context, line, byte_offset) do
      {:ok, acc, rest, context, line, offset} ->
        {:ok, :lists.reverse(acc), rest, context, line, offset}

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp extensions_and_private_use__0(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__1(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__1(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__26(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__3(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__4(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__4(
         <<x0, x1, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 === 120 or x0 === 88) and x1 === 45 do
    extensions_and_private_use__5(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp extensions_and_private_use__4(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected an 'x' representing a private use tag while processing a BCP-47 language tag locale extension or a BCP-47 language tag transform extension or a valid BCP-47 language tag extension, followed by ASCII character equal to '-', followed by a BCP-47 language tag locale extension or a BCP-47 language tag transform extension or a valid BCP-47 language tag extension, followed by ASCII character equal to '-', followed by an 'x' representing a private use tag or nothing or an 'x' representing a private use tag",
     rest, context, line, offset}
  end

  defp extensions_and_private_use__5(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__6(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__6(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__7(
      rest,
      [<<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__6(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected an 'x' representing a private use tag while processing a BCP-47 language tag locale extension or a BCP-47 language tag transform extension or a valid BCP-47 language tag extension, followed by ASCII character equal to '-', followed by a BCP-47 language tag locale extension or a BCP-47 language tag transform extension or a valid BCP-47 language tag extension, followed by ASCII character equal to '-', followed by an 'x' representing a private use tag or nothing or an 'x' representing a private use tag",
     rest, context, line, offset}
  end

  defp extensions_and_private_use__7(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__9(rest, acc, [7 | stack], context, line, offset)
  end

  defp extensions_and_private_use__9(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__10(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__9(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__8(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__8(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__11(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__10(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__11(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__10(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__9(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__11(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__12(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__12(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__14(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__14(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__15(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__14(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__13(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__15(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__16(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__16(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__17(
      rest,
      [<<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__16(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__13(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__17(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__19(rest, acc, [7 | stack], context, line, offset)
  end

  defp extensions_and_private_use__19(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__20(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__19(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__18(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__18(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__21(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__20(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__21(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__20(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__19(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__21(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__22(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__13(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    extensions_and_private_use__23(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__22(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__14(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__23(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__24(
      rest,
      [private_use: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__24(rest, acc, [_, previous_acc | stack], context, line, offset) do
    extensions_and_private_use__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__25(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__3(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__26(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__27(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__27(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__321(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__29(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__30(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__30(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__31(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__31(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 48 and x0 <= 57) or (x0 >= 97 and x0 <= 115) or (x0 >= 65 and x0 <= 83) or
              (x0 >= 118 and x0 <= 119) or (x0 >= 86 and x0 <= 87) or (x0 >= 121 and x0 <= 122) or
              (x0 >= 89 and x0 <= 90) do
    extensions_and_private_use__32(
      rest,
      [type: <<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__31(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    extensions_and_private_use__25(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__32(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__33(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__33(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__34(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__33(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, _, acc | stack] = stack
    extensions_and_private_use__25(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__34(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__35(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__35(
         <<x0, x1, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) do
    extensions_and_private_use__36(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp extensions_and_private_use__35(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, _, _, acc | stack] = stack
    extensions_and_private_use__25(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__36(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__38(rest, acc, [6 | stack], context, line, offset)
  end

  defp extensions_and_private_use__38(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__39(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__38(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__37(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__37(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__40(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__39(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__40(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__39(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__38(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__40(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__41(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__41(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__42(
      rest,
      [
        attribute:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__42(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__44(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__44(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__45(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__45(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__46(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__45(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__43(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__46(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__47(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__47(
         <<x0, x1, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) do
    extensions_and_private_use__48(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp extensions_and_private_use__47(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__43(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__48(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__50(rest, acc, [6 | stack], context, line, offset)
  end

  defp extensions_and_private_use__50(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__51(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__50(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__49(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__49(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__52(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__51(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__52(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__51(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__50(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__52(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__53(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__53(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__54(
      rest,
      [
        attribute:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__43(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    extensions_and_private_use__55(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__54(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__44(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__55(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__56(
      rest,
      [collapse_extension(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__56(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__57(
      rest,
      [
        extension:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__57(rest, acc, [_, previous_acc | stack], context, line, offset) do
    extensions_and_private_use__28(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__58(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__29(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__59(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__60(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__60(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__61(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__61(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 116 or x0 === 84 do
    extensions_and_private_use__62(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__61(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__58(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__62(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__66(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__64(rest, acc, [_, previous_acc | stack], context, line, offset) do
    extensions_and_private_use__63(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__65(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__64(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__66(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__67(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__66(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__65(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__67(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__68(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__68(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__206(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__70(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__71(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__71(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__72(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__72(
         <<x0, x1, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) do
    extensions_and_private_use__73(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp extensions_and_private_use__72(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    extensions_and_private_use__65(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__73(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__75(rest, acc, [1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__75(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) do
    extensions_and_private_use__76(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__75(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__74(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__74(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__77(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__76(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__77(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__76(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__75(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__77(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__78(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__78(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__79(
      rest,
      [
        language:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__79(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__83(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__81(rest, acc, [_, previous_acc | stack], context, line, offset) do
    extensions_and_private_use__80(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__82(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__81(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__83(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__84(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__83(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__82(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__84(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__85(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__85(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__87(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__87(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__92(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__89(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__90(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__89(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__86(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__90(rest, acc, [_, previous_acc | stack], context, line, offset) do
    extensions_and_private_use__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__91(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__89(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__92(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__93(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__93(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__94(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__93(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__91(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__94(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__96(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__96(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__97(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__96(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__95(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__95(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__98(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__97(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__98(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__97(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__96(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__98(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__99(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__99(rest, acc, [_, previous_acc | stack], context, line, offset) do
    extensions_and_private_use__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__88(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__100(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__100(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__82(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__86(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    extensions_and_private_use__101(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__101(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__181(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__103(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) do
    extensions_and_private_use__104(
      rest,
      [language_subtags: [<<x0::integer, x1::integer, x2::integer>>]] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__103(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__82(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__104(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__102(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__105(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__103(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__106(
         <<x0, x1, x2, x3, x4, x5, x6, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) do
    extensions_and_private_use__107(
      rest,
      [<<x4::integer, x5::integer, x6::integer>>, <<x0::integer, x1::integer, x2::integer>>] ++
        acc,
      stack,
      context,
      comb__line,
      comb__offset + 7
    )
  end

  defp extensions_and_private_use__106(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__105(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__107(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__102(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__108(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__106(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__109(
         <<x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 and
              ((x8 >= 97 and x8 <= 122) or (x8 >= 65 and x8 <= 90)) and
              ((x9 >= 97 and x9 <= 122) or (x9 >= 65 and x9 <= 90)) and
              ((x10 >= 97 and x10 <= 122) or (x10 >= 65 and x10 <= 90)) do
    extensions_and_private_use__110(
      rest,
      [
        <<x8::integer, x9::integer, x10::integer>>,
        <<x4::integer, x5::integer, x6::integer>>,
        <<x0::integer, x1::integer, x2::integer>>
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 11
    )
  end

  defp extensions_and_private_use__109(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__108(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__110(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__102(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__111(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__109(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__112(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 do
    extensions_and_private_use__113(
      rest,
      [language_subtags: [<<x0::integer, x1::integer, x2::integer>>]] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__112(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__111(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__113(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__114(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__114(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__115(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__115(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__117(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__117(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__122(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__119(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__120(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__119(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__116(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__120(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__118(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__121(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__119(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__122(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__123(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__123(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__124(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__123(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__121(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__124(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__126(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__126(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__127(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__126(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__125(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__125(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__128(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__127(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__128(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__127(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__126(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__128(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__129(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__129(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__118(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__118(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__130(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__130(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__111(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__116(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__131(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__131(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__132(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__131(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__111(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__132(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__133(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__133(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__102(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__134(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__112(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__135(
         <<x0, x1, x2, x3, x4, x5, x6, x7, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 do
    extensions_and_private_use__136(
      rest,
      [
        language_subtags: [
          <<x0::integer, x1::integer, x2::integer>>,
          <<x4::integer, x5::integer, x6::integer>>
        ]
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 8
    )
  end

  defp extensions_and_private_use__135(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__134(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__136(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__137(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__137(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__138(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__138(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__140(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__140(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__145(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__142(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__143(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__142(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__139(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__143(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__144(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__142(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__145(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__146(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__146(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__147(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__146(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__144(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__147(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__149(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__149(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__150(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__149(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__148(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__148(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__151(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__150(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__151(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__150(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__149(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__151(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__152(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__152(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__141(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__153(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__153(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__134(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__139(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__154(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__154(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__155(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__154(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__134(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__155(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__156(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__156(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__102(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__157(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__135(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__158(
         <<x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 and
              ((x8 >= 97 and x8 <= 122) or (x8 >= 65 and x8 <= 90)) and
              ((x9 >= 97 and x9 <= 122) or (x9 >= 65 and x9 <= 90)) and
              ((x10 >= 97 and x10 <= 122) or (x10 >= 65 and x10 <= 90)) and x11 === 45 do
    extensions_and_private_use__159(
      rest,
      [
        language_subtags: [
          <<x0::integer, x1::integer, x2::integer>>,
          <<x4::integer, x5::integer, x6::integer>>,
          <<x8::integer, x9::integer, x10::integer>>
        ]
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 12
    )
  end

  defp extensions_and_private_use__158(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__157(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__159(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__160(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__160(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__161(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__161(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__163(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__163(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__168(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__165(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__166(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__165(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__162(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__166(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__164(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__167(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__165(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__168(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__169(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__169(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__170(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__169(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__167(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__170(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__172(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__172(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__173(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__172(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__171(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__171(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__174(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__173(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__174(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__173(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__172(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__174(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__175(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__175(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__164(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__164(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__176(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__176(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__157(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__162(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__177(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__177(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__178(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__177(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__157(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__178(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__179(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__179(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__102(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__180(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__158(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__181(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__182(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__182(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__183(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__183(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__185(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__185(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__190(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__187(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__188(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__187(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__184(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__188(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__186(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__189(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__187(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__190(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__191(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__191(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__192(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__191(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__189(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__192(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__194(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__194(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__195(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__194(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__193(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__193(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__196(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__195(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__196(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__195(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__194(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__196(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__197(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__197(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__186(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__186(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__198(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__198(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__180(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__184(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__199(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__199(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__200(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__199(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__180(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__200(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__201(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__201(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__102(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__102(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__80(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__80(rest, acc, [_, previous_acc | stack], context, line, offset) do
    extensions_and_private_use__69(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__202(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__70(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__203(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__204(
      rest,
      [language: <<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__203(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__202(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__204(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__69(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__205(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__203(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__206(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__207(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__207(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__208(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__208(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) do
    extensions_and_private_use__209(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__208(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__205(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__209(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__211(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__211(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) do
    extensions_and_private_use__212(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__211(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__210(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__210(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__213(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__212(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__213(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__212(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__211(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__213(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__214(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__214(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__215(
      rest,
      [
        language:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__215(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__69(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__69(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__219(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__217(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__216(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__218(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__217(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__219(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__220(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__219(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__218(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__220(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__221(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__221(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__222(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__222(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__224(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__224(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__229(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__226(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__227(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__226(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__223(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__227(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__225(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__228(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__226(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__229(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__230(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__230(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__231(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__230(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__228(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__231(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__233(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__233(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__234(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__233(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__232(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__232(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__235(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__234(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__235(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__234(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__233(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__235(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__236(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__236(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__225(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__225(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__237(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__237(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__218(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__223(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__238(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__238(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__239(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__238(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__218(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__239(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__240(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__240(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__216(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__216(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__244(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__242(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__241(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__243(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__242(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__244(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__245(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__244(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__243(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__245(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__246(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__246(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__247(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__247(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__249(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__249(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__254(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__251(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__252(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__251(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__248(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__252(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__250(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__253(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__251(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__254(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__255(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__255(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__256(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__255(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__253(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__256(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__258(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__258(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__259(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__258(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__257(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__257(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__260(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__259(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__260(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__259(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__258(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__260(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__261(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__261(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__250(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__250(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__262(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__262(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__243(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__248(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__263(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__263(
         <<x0, x1, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) do
    extensions_and_private_use__264(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp extensions_and_private_use__263(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) do
    extensions_and_private_use__264(
      rest,
      [x2 - 48 + (x1 - 48) * 10 + (x0 - 48) * 100] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__263(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__243(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__264(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__265(
      rest,
      [
        territory:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__265(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__241(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__241(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__267(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__267(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__268(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__267(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__266(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__268(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__269(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__269(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__274(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__271(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__272(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__271(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__266(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__272(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__270(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__273(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__271(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__274(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__275(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__275(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__276(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__275(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__273(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__276(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__278(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__278(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__279(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__278(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__277(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__277(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__280(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__279(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__280(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__279(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__278(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__280(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__281(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__281(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__270(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__270(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__282(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__266(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__283(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__282(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__267(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__283(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__284(
      rest,
      [collapse_variants(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__284(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__63(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__63(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__285(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__285(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__287(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__287(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__288(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__287(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__286(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__288(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__292(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__290(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__289(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__291(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__290(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__292(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__293(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__292(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__291(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__293(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__294(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__294(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__295(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__295(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__296(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__295(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__291(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__296(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__298(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__298(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__299(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__298(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__297(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__297(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__300(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__299(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__300(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__299(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__298(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__300(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__301(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__301(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__302(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__302(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__304(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__304(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__305(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__305(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__306(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__305(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__303(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__306(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__307(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__307(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__308(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__307(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__303(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__308(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__310(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__310(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__311(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__310(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__309(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__309(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__312(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__311(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__312(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__311(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__310(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__312(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__313(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__313(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__314(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__303(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__315(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__314(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__304(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__315(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__289(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__286(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__316(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__289(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__287(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__316(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__317(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__317(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__318(
      rest,
      [merge_langtag_and_transform(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__318(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__319(
      rest,
      [
        transform:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__319(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__28(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__320(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__59(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__321(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__322(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__322(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__323(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__323(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 117 or x0 === 85 do
    extensions_and_private_use__324(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__323(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__320(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__324(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__361(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__326(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__327(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__327(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__329(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__329(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__330(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__329(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__328(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__330(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__334(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__332(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__331(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__333(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__332(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__334(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__335(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__334(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__333(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__335(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__336(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__336(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__337(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__337(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__338(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__337(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__333(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__338(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__340(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__340(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__341(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__340(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__339(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__339(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__342(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__341(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__342(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__341(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__340(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__342(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__343(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__343(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__344(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__344(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__346(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__346(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__347(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__347(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__348(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__347(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__345(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__348(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__349(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__349(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__350(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__349(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__345(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__350(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__352(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__352(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__353(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__352(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__351(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__351(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__354(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__353(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__354(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__353(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__352(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__354(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__355(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__355(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__356(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__345(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__357(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__356(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__346(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__357(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__331(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__328(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__358(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__331(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__329(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__358(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__359(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__359(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__325(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__360(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__326(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__361(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__362(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__362(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__363(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__362(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__360(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__363(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__364(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__364(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__365(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__364(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__360(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__365(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__367(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__367(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__368(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__367(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__366(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__366(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__369(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__368(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__369(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__368(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__367(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__369(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__370(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__370(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__372(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__372(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__373(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__372(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__371(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__373(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__374(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__374(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__375(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__374(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__371(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__375(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__377(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__377(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__378(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__377(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__376(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__376(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__379(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__378(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__379(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__378(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__377(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__379(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__380(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__371(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__381(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__380(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__372(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__381(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__382(
      rest,
      [attributes: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__382(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__383(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__383(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__385(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__385(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__386(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__385(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__384(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__386(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__390(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__388(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__387(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__389(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__388(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__390(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__391(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__390(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__389(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__391(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__392(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__392(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__393(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__393(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__394(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__393(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__389(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__394(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__396(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__396(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__397(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__396(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__395(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__395(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__398(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__397(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__398(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__397(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__396(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__398(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__399(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__399(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__400(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__400(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__402(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__402(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__403(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__403(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__404(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__403(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__401(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__404(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__405(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__405(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__406(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__405(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__401(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__406(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__408(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__408(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__409(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__408(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__407(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__407(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__410(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__409(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__410(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__409(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__408(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__410(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__411(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__411(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__412(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__401(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__413(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__412(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__402(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__413(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__387(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__384(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__414(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__387(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__385(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__414(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__415(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__415(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__325(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__325(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__416(
      rest,
      [combine_attributes_and_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__416(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__417(
      rest,
      [
        locale:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__417(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__28(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__28(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__419(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__419(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__420(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__419(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__418(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__420(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__714(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__422(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__423(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__423(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__424(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__424(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 48 and x0 <= 57) or (x0 >= 97 and x0 <= 115) or (x0 >= 65 and x0 <= 83) or
              (x0 >= 118 and x0 <= 119) or (x0 >= 86 and x0 <= 87) or (x0 >= 121 and x0 <= 122) or
              (x0 >= 89 and x0 <= 90) do
    extensions_and_private_use__425(
      rest,
      [type: <<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__424(rest, _acc, stack, context, line, offset) do
    [_, _, _, acc | stack] = stack
    extensions_and_private_use__418(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__425(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__426(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__426(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__427(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__426(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    extensions_and_private_use__418(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__427(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__428(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__428(
         <<x0, x1, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) do
    extensions_and_private_use__429(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp extensions_and_private_use__428(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, _, acc | stack] = stack
    extensions_and_private_use__418(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__429(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__431(rest, acc, [6 | stack], context, line, offset)
  end

  defp extensions_and_private_use__431(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__432(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__431(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__430(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__430(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__433(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__432(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__433(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__432(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__431(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__433(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__434(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__434(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__435(
      rest,
      [
        attribute:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__435(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__437(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__437(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__438(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__438(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__439(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__438(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__436(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__439(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__440(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__440(
         <<x0, x1, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) do
    extensions_and_private_use__441(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp extensions_and_private_use__440(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__436(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__441(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__443(rest, acc, [6 | stack], context, line, offset)
  end

  defp extensions_and_private_use__443(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__444(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__443(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__442(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__442(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__445(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__444(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__445(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__444(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__443(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__445(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__446(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__446(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__447(
      rest,
      [
        attribute:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__436(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__448(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__447(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__437(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__448(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__449(
      rest,
      [collapse_extension(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__449(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__450(
      rest,
      [
        extension:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__450(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__421(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__451(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__422(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__452(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__453(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__453(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__454(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__454(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 116 or x0 === 84 do
    extensions_and_private_use__455(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__454(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__451(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__455(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__459(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__457(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__456(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__458(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__457(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__459(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__460(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__459(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__458(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__460(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__461(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__461(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__599(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__463(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__464(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__464(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__465(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__465(
         <<x0, x1, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) do
    extensions_and_private_use__466(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp extensions_and_private_use__465(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    extensions_and_private_use__458(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__466(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__468(rest, acc, [1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__468(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) do
    extensions_and_private_use__469(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__468(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__467(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__467(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__470(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__469(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__470(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__469(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__468(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__470(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__471(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__471(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__472(
      rest,
      [
        language:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__472(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__476(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__474(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__473(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__475(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__474(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__476(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__477(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__476(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__475(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__477(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__478(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__478(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__480(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__480(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__485(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__482(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__483(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__482(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__479(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__483(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__481(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__484(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__482(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__485(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__486(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__486(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__487(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__486(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__484(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__487(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__489(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__489(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__490(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__489(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__488(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__488(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__491(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__490(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__491(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__490(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__489(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__491(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__492(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__492(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__481(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__481(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__493(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__493(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__475(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__479(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__494(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__494(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__574(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__496(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) do
    extensions_and_private_use__497(
      rest,
      [language_subtags: [<<x0::integer, x1::integer, x2::integer>>]] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__496(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__475(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__497(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__495(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__498(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__496(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__499(
         <<x0, x1, x2, x3, x4, x5, x6, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) do
    extensions_and_private_use__500(
      rest,
      [<<x4::integer, x5::integer, x6::integer>>, <<x0::integer, x1::integer, x2::integer>>] ++
        acc,
      stack,
      context,
      comb__line,
      comb__offset + 7
    )
  end

  defp extensions_and_private_use__499(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__498(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__500(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__495(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__501(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__499(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__502(
         <<x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 and
              ((x8 >= 97 and x8 <= 122) or (x8 >= 65 and x8 <= 90)) and
              ((x9 >= 97 and x9 <= 122) or (x9 >= 65 and x9 <= 90)) and
              ((x10 >= 97 and x10 <= 122) or (x10 >= 65 and x10 <= 90)) do
    extensions_and_private_use__503(
      rest,
      [
        <<x8::integer, x9::integer, x10::integer>>,
        <<x4::integer, x5::integer, x6::integer>>,
        <<x0::integer, x1::integer, x2::integer>>
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 11
    )
  end

  defp extensions_and_private_use__502(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__501(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__503(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__495(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__504(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__502(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__505(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 do
    extensions_and_private_use__506(
      rest,
      [language_subtags: [<<x0::integer, x1::integer, x2::integer>>]] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__505(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__504(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__506(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__507(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__507(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__508(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__508(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__510(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__510(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__515(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__512(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__513(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__512(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__509(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__513(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__511(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__514(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__512(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__515(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__516(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__516(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__517(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__516(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__514(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__517(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__519(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__519(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__520(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__519(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__518(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__518(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__521(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__520(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__521(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__520(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__519(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__521(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__522(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__522(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__511(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__511(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__523(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__523(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__504(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__509(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__524(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__524(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__525(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__524(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__504(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__525(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__526(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__526(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__495(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__527(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__505(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__528(
         <<x0, x1, x2, x3, x4, x5, x6, x7, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 do
    extensions_and_private_use__529(
      rest,
      [
        language_subtags: [
          <<x0::integer, x1::integer, x2::integer>>,
          <<x4::integer, x5::integer, x6::integer>>
        ]
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 8
    )
  end

  defp extensions_and_private_use__528(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__527(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__529(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__530(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__530(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__531(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__531(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__533(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__533(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__538(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__535(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__536(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__535(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__532(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__536(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__534(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__537(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__535(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__538(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__539(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__539(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__540(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__539(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__537(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__540(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__542(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__542(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__543(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__542(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__541(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__541(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__544(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__543(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__544(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__543(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__542(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__544(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__545(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__545(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__534(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__534(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__546(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__546(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__527(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__532(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__547(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__547(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__548(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__547(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__527(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__548(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__549(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__549(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__495(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__550(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__528(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__551(
         <<x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 and
              ((x8 >= 97 and x8 <= 122) or (x8 >= 65 and x8 <= 90)) and
              ((x9 >= 97 and x9 <= 122) or (x9 >= 65 and x9 <= 90)) and
              ((x10 >= 97 and x10 <= 122) or (x10 >= 65 and x10 <= 90)) and x11 === 45 do
    extensions_and_private_use__552(
      rest,
      [
        language_subtags: [
          <<x0::integer, x1::integer, x2::integer>>,
          <<x4::integer, x5::integer, x6::integer>>,
          <<x8::integer, x9::integer, x10::integer>>
        ]
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 12
    )
  end

  defp extensions_and_private_use__551(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__550(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__552(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__553(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__553(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__554(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__554(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__556(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__556(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__561(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__558(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__559(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__558(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__555(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__559(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__557(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__560(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__558(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__561(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__562(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__562(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__563(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__562(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__560(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__563(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__565(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__565(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__566(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__565(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__564(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__564(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__567(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__566(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__567(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__566(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__565(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__567(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__568(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__568(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__557(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__557(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__569(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__569(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__550(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__555(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__570(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__570(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__571(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__570(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__550(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__571(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__572(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__572(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__495(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__573(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__551(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__574(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__575(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__575(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__576(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__576(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__578(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__578(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__583(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__580(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__581(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__580(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__577(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__581(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__579(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__582(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__580(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__583(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__584(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__584(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__585(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__584(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__582(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__585(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__587(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__587(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__588(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__587(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__586(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__586(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__589(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__588(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__589(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__588(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__587(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__589(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__590(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__590(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__579(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__579(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__591(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__591(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__573(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__577(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__592(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__592(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__593(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__592(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__573(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__593(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__594(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__594(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__495(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__495(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__473(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__473(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__462(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__595(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__463(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__596(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__597(
      rest,
      [language: <<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__596(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__595(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__597(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__462(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__598(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__596(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__599(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__600(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__600(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__601(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__601(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) do
    extensions_and_private_use__602(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__601(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__598(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__602(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__604(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__604(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) do
    extensions_and_private_use__605(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__604(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__603(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__603(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__606(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__605(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__606(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__605(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__604(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__606(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__607(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__607(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__608(
      rest,
      [
        language:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__608(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__462(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__462(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__612(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__610(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__609(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__611(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__610(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__612(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__613(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__612(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__611(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__613(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__614(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__614(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__615(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__615(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__617(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__617(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__622(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__619(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__620(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__619(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__616(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__620(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__618(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__621(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__619(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__622(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__623(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__623(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__624(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__623(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__621(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__624(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__626(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__626(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__627(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__626(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__625(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__625(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__628(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__627(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__628(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__627(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__626(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__628(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__629(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__629(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__618(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__618(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__630(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__630(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__611(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__616(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__631(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__631(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    extensions_and_private_use__632(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__631(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__611(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__632(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__633(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__633(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__609(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__609(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__637(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__635(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__634(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__636(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__635(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__637(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__638(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__637(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__636(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__638(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__639(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__639(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__640(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__640(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__642(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__642(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__647(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__644(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__645(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__644(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__641(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__645(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__643(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__646(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__644(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__647(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__648(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__648(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__649(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__648(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__646(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__649(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__651(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__651(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__652(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__651(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__650(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__650(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__653(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__652(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__653(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__652(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__651(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__653(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__654(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__654(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__643(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__643(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__655(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__655(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    [acc | stack] = stack
    extensions_and_private_use__636(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__641(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__656(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__656(
         <<x0, x1, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) do
    extensions_and_private_use__657(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp extensions_and_private_use__656(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) do
    extensions_and_private_use__657(
      rest,
      [x2 - 48 + (x1 - 48) * 10 + (x0 - 48) * 100] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__656(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__636(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__657(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__658(
      rest,
      [
        territory:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__658(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__634(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__634(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__660(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__660(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__661(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__660(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__659(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__661(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__662(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__662(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__667(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__664(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    extensions_and_private_use__665(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp extensions_and_private_use__664(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    extensions_and_private_use__659(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__665(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__663(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__666(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__664(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__667(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__668(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__668(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    extensions_and_private_use__669(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp extensions_and_private_use__668(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__666(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__669(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__671(rest, acc, [3 | stack], context, line, offset)
  end

  defp extensions_and_private_use__671(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__672(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__671(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__670(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__670(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__673(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__672(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__673(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__672(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__671(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__673(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__674(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__674(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__663(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__663(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__675(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__659(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__676(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__675(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__660(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__676(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__677(
      rest,
      [collapse_variants(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__677(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__456(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__456(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__678(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__678(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__680(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__680(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__681(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__680(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__679(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__681(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__685(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__683(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__682(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__684(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__683(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__685(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__686(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__685(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__684(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__686(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__687(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__687(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__688(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__688(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__689(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__688(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__684(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__689(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__691(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__691(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__692(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__691(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__690(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__690(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__693(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__692(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__693(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__692(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__691(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__693(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__694(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__694(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__695(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__695(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__697(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__697(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__698(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__698(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__699(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__698(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__696(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__699(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__700(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__700(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__701(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__700(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__696(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__701(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__703(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__703(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__704(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__703(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__702(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__702(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__705(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__704(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__705(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__704(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__703(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__705(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__706(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__706(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__707(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__696(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__708(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__707(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__697(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__708(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__682(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__679(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__709(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__682(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__680(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__709(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__710(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__710(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__711(
      rest,
      [merge_langtag_and_transform(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__711(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__712(
      rest,
      [
        transform:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__712(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__421(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__713(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__452(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__714(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__715(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__715(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__716(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__716(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 117 or x0 === 85 do
    extensions_and_private_use__717(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__716(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__713(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__717(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__754(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__719(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__720(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__720(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__722(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__722(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__723(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__722(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__721(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__723(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__727(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__725(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__724(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__726(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__725(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__727(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__728(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__727(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__726(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__728(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__729(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__729(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__730(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__730(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__731(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__730(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__726(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__731(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__733(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__733(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__734(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__733(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__732(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__732(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__735(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__734(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__735(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__734(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__733(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__735(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__736(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__736(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__737(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__737(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__739(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__739(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__740(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__740(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__741(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__740(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__738(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__741(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__742(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__742(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__743(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__742(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__738(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__743(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__745(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__745(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__746(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__745(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__744(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__744(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__747(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__746(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__747(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__746(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__745(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__747(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__748(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__748(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__749(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__738(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__750(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__749(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__739(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__750(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__724(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__721(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__751(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__724(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__722(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__751(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__752(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__752(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__718(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__753(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__719(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__754(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__755(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__755(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__756(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__755(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__753(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__756(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__757(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__757(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__758(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__757(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__753(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__758(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__760(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__760(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__761(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__760(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__759(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__759(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__762(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__761(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__762(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__761(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__760(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__762(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__763(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__763(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__765(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__765(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__766(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__765(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__764(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__766(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__767(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__767(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__768(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__767(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__764(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__768(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__770(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__770(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__771(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__770(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__769(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__769(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__772(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__771(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__772(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__771(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__770(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__772(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__773(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__764(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__774(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__773(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__765(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__774(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__775(
      rest,
      [attributes: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__775(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__776(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__776(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__778(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__778(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__779(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__778(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__777(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__779(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__783(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__781(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__780(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__782(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__781(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__783(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__784(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__783(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__782(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__784(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__785(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__785(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__786(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__786(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__787(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__786(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__782(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__787(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__789(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__789(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__790(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__789(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__788(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__788(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__791(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__790(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__791(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__790(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__789(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__791(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__792(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__792(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__793(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__793(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__795(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__795(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__796(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__796(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__797(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__796(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__794(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__797(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__798(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__798(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    extensions_and_private_use__799(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp extensions_and_private_use__798(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__794(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__799(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__801(rest, acc, [5 | stack], context, line, offset)
  end

  defp extensions_and_private_use__801(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__802(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__801(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__800(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__800(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__803(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__802(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__803(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__802(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__801(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__803(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__804(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__804(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__805(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__794(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__806(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__805(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__795(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__806(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__780(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__777(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__807(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__780(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__778(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__807(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__808(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__808(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__718(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__718(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__809(
      rest,
      [combine_attributes_and_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__809(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__810(
      rest,
      [
        locale:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__810(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__421(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__418(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__811(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__421(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__419(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__811(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__812(
      rest,
      [collapse_extensions(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__812(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__816(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__814(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__813(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__815(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    extensions_and_private_use__814(rest, [], stack, context, line, offset)
  end

  defp extensions_and_private_use__816(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__817(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__816(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__815(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__817(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__818(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__818(
         <<x0, x1, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 === 120 or x0 === 88) and x1 === 45 do
    extensions_and_private_use__819(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp extensions_and_private_use__818(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__815(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__819(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__820(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__820(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__821(
      rest,
      [<<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__820(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    extensions_and_private_use__815(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__821(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__823(rest, acc, [7 | stack], context, line, offset)
  end

  defp extensions_and_private_use__823(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__824(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__823(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__822(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__822(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__825(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__824(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__825(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__824(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__823(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__825(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__826(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__826(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__828(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__828(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 do
    extensions_and_private_use__829(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp extensions_and_private_use__828(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__827(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__829(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__830(rest, [], [acc | stack], context, line, offset)
  end

  defp extensions_and_private_use__830(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__831(
      rest,
      [<<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__830(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    extensions_and_private_use__827(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__831(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__833(rest, acc, [7 | stack], context, line, offset)
  end

  defp extensions_and_private_use__833(
         <<x0, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    extensions_and_private_use__834(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp extensions_and_private_use__833(rest, acc, stack, context, line, offset) do
    extensions_and_private_use__832(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__832(rest, acc, [_ | stack], context, line, offset) do
    extensions_and_private_use__835(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__834(rest, acc, [1 | stack], context, line, offset) do
    extensions_and_private_use__835(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__834(rest, acc, [count | stack], context, line, offset) do
    extensions_and_private_use__833(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp extensions_and_private_use__835(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__836(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__827(
         _,
         _,
         [{rest, acc, context, line, offset} | stack],
         _,
         _,
         _
       ) do
    extensions_and_private_use__837(rest, acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__836(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    extensions_and_private_use__828(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp extensions_and_private_use__837(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    extensions_and_private_use__838(
      rest,
      [private_use: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp extensions_and_private_use__838(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__813(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__813(
         rest,
         acc,
         [_, previous_acc | stack],
         context,
         line,
         offset
       ) do
    extensions_and_private_use__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp extensions_and_private_use__2(rest, user_acc, [acc | stack], context, line, offset) do
    case (case flatten(rest, user_acc, context, line, offset) do
            {_, _, _} = res -> res
            {:error, reason} -> {:error, reason}
            {acc, context} -> {rest, acc, context}
          end) do
      {rest, user_acc, context} when is_list(user_acc) ->
        extensions_and_private_use__839(rest, user_acc ++ acc, stack, context, line, offset)

      {:error, reason} ->
        {:error, reason, rest, context, line, offset}
    end
  end

  defp extensions_and_private_use__839(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  @doc """
  Parses the given `binary` as language_tag.

  Returns `{:ok, [token], rest, context, position, byte_offset}` or
  `{:error, reason, rest, context, line, byte_offset}` where `position`
  describes the location of the language_tag (start position) as `{line, offset_to_start_of_line}`.

  To column where the error occurred can be inferred from `byte_offset - offset_to_start_of_line`.

  ## Options

    * `:byte_offset` - the byte offset for the whole binary, defaults to 0
    * `:line` - the line and the byte offset into that line, defaults to `{1, byte_offset}`
    * `:context` - the initial context value. It will be converted to a map

  """
  @spec language_tag(binary, keyword) ::
          {:ok, [term], rest, context, line, byte_offset}
          | {:error, reason, rest, context, line, byte_offset}
        when line: {pos_integer, byte_offset},
             byte_offset: pos_integer,
             rest: binary,
             reason: String.t(),
             context: map
  def language_tag(binary, opts \\ []) when is_binary(binary) do
    context = Map.new(Keyword.get(opts, :context, []))
    byte_offset = Keyword.get(opts, :byte_offset, 0)

    line =
      case Keyword.get(opts, :line, 1) do
        {_, _} = line -> line
        line -> {line, byte_offset}
      end

    case language_tag__0(binary, [], [], context, line, byte_offset) do
      {:ok, acc, rest, context, line, offset} ->
        {:ok, :lists.reverse(acc), rest, context, line, offset}

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp language_tag__0(rest, acc, stack, context, line, offset) do
    language_tag__39(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__2(rest, acc, stack, context, line, offset) do
    language_tag__3(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__3(rest, acc, stack, context, line, offset) do
    language_tag__10(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__5(rest, acc, stack, context, line, offset) do
    language_tag__6(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__6(
         <<"art-lojban", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__7(rest, ["art-lojban"] ++ acc, stack, context, comb__line, comb__offset + 10)
  end

  defp language_tag__6(
         <<"cel-gaulish", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__7(rest, ["cel-gaulish"] ++ acc, stack, context, comb__line, comb__offset + 11)
  end

  defp language_tag__6(<<"no-bok", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__7(rest, ["no-bok"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp language_tag__6(<<"no-nyn", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__7(rest, ["no-nyn"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp language_tag__6(
         <<"zh-guoyu", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__7(rest, ["zh-guoyu"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp language_tag__6(
         <<"zh-hakka", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__7(rest, ["zh-hakka"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp language_tag__6(<<"zh-min", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__7(rest, ["zh-min"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp language_tag__6(
         <<"zh-min-nan", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__7(rest, ["zh-min-nan"] ++ acc, stack, context, comb__line, comb__offset + 10)
  end

  defp language_tag__6(
         <<"zh-xiang", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__7(rest, ["zh-xiang"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp language_tag__6(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected one of the regular language tags in BCP-47 while processing a grandfathered language tag inside a BCP47 language tag",
     rest, context, line, offset}
  end

  defp language_tag__7(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__8(
      rest,
      [
        regular:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__8(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__4(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__9(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__5(rest, [], stack, context, line, offset)
  end

  defp language_tag__10(rest, acc, stack, context, line, offset) do
    language_tag__11(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__11(
         <<"en-GB-oed", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__12(rest, ["en-GB-oed"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp language_tag__11(<<"i-ami", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__12(rest, ["i-ami"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp language_tag__11(<<"i-bnn", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__12(rest, ["i-bnn"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp language_tag__11(
         <<"i-default", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__12(rest, ["i-default"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp language_tag__11(
         <<"i-enochian", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__12(rest, ["i-enochian"] ++ acc, stack, context, comb__line, comb__offset + 10)
  end

  defp language_tag__11(<<"i-hak", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__12(rest, ["i-hak"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp language_tag__11(
         <<"i-klingon", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__12(rest, ["i-klingon"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp language_tag__11(<<"i-lux", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__12(rest, ["i-lux"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp language_tag__11(
         <<"i-mingo", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__12(rest, ["i-mingo"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp language_tag__11(
         <<"i-navajo", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__12(rest, ["i-navajo"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp language_tag__11(<<"i-pwn", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__12(rest, ["i-pwn"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp language_tag__11(<<"i-tao", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__12(rest, ["i-tao"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp language_tag__11(<<"i-tay", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__12(rest, ["i-tay"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp language_tag__11(<<"i-tsu", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__12(rest, ["i-tsu"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp language_tag__11(
         <<"sgn-BE-FR", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__12(rest, ["sgn-BE-FR"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp language_tag__11(
         <<"sgn-BE-NL", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__12(rest, ["sgn-BE-NL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp language_tag__11(
         <<"sgn-CH-DE", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    language_tag__12(rest, ["sgn-CH-DE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp language_tag__11(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__9(rest, acc, stack, context, line, offset)
  end

  defp language_tag__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__13(
      rest,
      [
        irregular:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__13(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__4(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__14(
      rest,
      [grandfathered: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__14(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__15(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__2(rest, [], stack, context, line, offset)
  end

  defp language_tag__16(rest, acc, stack, context, line, offset) do
    language_tag__17(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__17(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 === 120 or x0 === 88) and x1 === 45 do
    language_tag__18(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp language_tag__17(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__15(rest, acc, stack, context, line, offset)
  end

  defp language_tag__18(rest, acc, stack, context, line, offset) do
    language_tag__19(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__19(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__20(rest, [<<x0::integer>>] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__19(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__15(rest, acc, stack, context, line, offset)
  end

  defp language_tag__20(rest, acc, stack, context, line, offset) do
    language_tag__22(rest, acc, [7 | stack], context, line, offset)
  end

  defp language_tag__22(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__23(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__22(rest, acc, stack, context, line, offset) do
    language_tag__21(rest, acc, stack, context, line, offset)
  end

  defp language_tag__21(rest, acc, [_ | stack], context, line, offset) do
    language_tag__24(rest, acc, stack, context, line, offset)
  end

  defp language_tag__23(rest, acc, [1 | stack], context, line, offset) do
    language_tag__24(rest, acc, stack, context, line, offset)
  end

  defp language_tag__23(rest, acc, [count | stack], context, line, offset) do
    language_tag__22(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__24(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__25(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__25(rest, acc, stack, context, line, offset) do
    language_tag__27(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__27(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__28(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__27(rest, acc, stack, context, line, offset) do
    language_tag__26(rest, acc, stack, context, line, offset)
  end

  defp language_tag__28(rest, acc, stack, context, line, offset) do
    language_tag__29(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__29(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__30(rest, [<<x0::integer>>] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__29(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__26(rest, acc, stack, context, line, offset)
  end

  defp language_tag__30(rest, acc, stack, context, line, offset) do
    language_tag__32(rest, acc, [7 | stack], context, line, offset)
  end

  defp language_tag__32(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__33(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__32(rest, acc, stack, context, line, offset) do
    language_tag__31(rest, acc, stack, context, line, offset)
  end

  defp language_tag__31(rest, acc, [_ | stack], context, line, offset) do
    language_tag__34(rest, acc, stack, context, line, offset)
  end

  defp language_tag__33(rest, acc, [1 | stack], context, line, offset) do
    language_tag__34(rest, acc, stack, context, line, offset)
  end

  defp language_tag__33(rest, acc, [count | stack], context, line, offset) do
    language_tag__32(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__34(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__35(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__26(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__36(rest, acc, stack, context, line, offset)
  end

  defp language_tag__35(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__27(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__36(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__37(
      rest,
      [private_use: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__37(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__38(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__16(rest, [], stack, context, line, offset)
  end

  defp language_tag__39(rest, acc, stack, context, line, offset) do
    language_tag__40(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__40(rest, acc, stack, context, line, offset) do
    language_tag__41(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__41(rest, acc, stack, context, line, offset) do
    language_tag__179(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__43(rest, acc, stack, context, line, offset) do
    language_tag__44(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__44(rest, acc, stack, context, line, offset) do
    language_tag__45(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__45(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) do
    language_tag__46(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp language_tag__45(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, _, acc | stack] = stack
    language_tag__38(rest, acc, stack, context, line, offset)
  end

  defp language_tag__46(rest, acc, stack, context, line, offset) do
    language_tag__48(rest, acc, [1 | stack], context, line, offset)
  end

  defp language_tag__48(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) do
    language_tag__49(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__48(rest, acc, stack, context, line, offset) do
    language_tag__47(rest, acc, stack, context, line, offset)
  end

  defp language_tag__47(rest, acc, [_ | stack], context, line, offset) do
    language_tag__50(rest, acc, stack, context, line, offset)
  end

  defp language_tag__49(rest, acc, [1 | stack], context, line, offset) do
    language_tag__50(rest, acc, stack, context, line, offset)
  end

  defp language_tag__49(rest, acc, [count | stack], context, line, offset) do
    language_tag__48(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__50(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__51(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__51(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__52(
      rest,
      [
        language:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__52(rest, acc, stack, context, line, offset) do
    language_tag__56(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__54(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__53(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__55(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__54(rest, [], stack, context, line, offset)
  end

  defp language_tag__56(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__57(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__56(rest, acc, stack, context, line, offset) do
    language_tag__55(rest, acc, stack, context, line, offset)
  end

  defp language_tag__57(rest, acc, stack, context, line, offset) do
    language_tag__58(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__58(rest, acc, stack, context, line, offset) do
    language_tag__60(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__60(rest, acc, stack, context, line, offset) do
    language_tag__65(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__62(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__63(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__62(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__59(rest, acc, stack, context, line, offset)
  end

  defp language_tag__63(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__61(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__64(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__62(rest, [], stack, context, line, offset)
  end

  defp language_tag__65(rest, acc, stack, context, line, offset) do
    language_tag__66(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__66(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__67(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__66(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__64(rest, acc, stack, context, line, offset)
  end

  defp language_tag__67(rest, acc, stack, context, line, offset) do
    language_tag__69(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__69(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__70(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__69(rest, acc, stack, context, line, offset) do
    language_tag__68(rest, acc, stack, context, line, offset)
  end

  defp language_tag__68(rest, acc, [_ | stack], context, line, offset) do
    language_tag__71(rest, acc, stack, context, line, offset)
  end

  defp language_tag__70(rest, acc, [1 | stack], context, line, offset) do
    language_tag__71(rest, acc, stack, context, line, offset)
  end

  defp language_tag__70(rest, acc, [count | stack], context, line, offset) do
    language_tag__69(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__71(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__72(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__72(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__61(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__61(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__73(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__73(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__55(rest, acc, stack, context, line, offset)
  end

  defp language_tag__59(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__74(rest, acc, stack, context, line, offset)
  end

  defp language_tag__74(rest, acc, stack, context, line, offset) do
    language_tag__154(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__76(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) do
    language_tag__77(
      rest,
      [language_subtags: [<<x0::integer, x1::integer, x2::integer>>]] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__76(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__55(rest, acc, stack, context, line, offset)
  end

  defp language_tag__77(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__75(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__78(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__76(rest, [], stack, context, line, offset)
  end

  defp language_tag__79(
         <<x0, x1, x2, x3, x4, x5, x6, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) do
    language_tag__80(
      rest,
      [<<x4::integer, x5::integer, x6::integer>>, <<x0::integer, x1::integer, x2::integer>>] ++
        acc,
      stack,
      context,
      comb__line,
      comb__offset + 7
    )
  end

  defp language_tag__79(rest, acc, stack, context, line, offset) do
    language_tag__78(rest, acc, stack, context, line, offset)
  end

  defp language_tag__80(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__75(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__81(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__79(rest, [], stack, context, line, offset)
  end

  defp language_tag__82(
         <<x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 and
              ((x8 >= 97 and x8 <= 122) or (x8 >= 65 and x8 <= 90)) and
              ((x9 >= 97 and x9 <= 122) or (x9 >= 65 and x9 <= 90)) and
              ((x10 >= 97 and x10 <= 122) or (x10 >= 65 and x10 <= 90)) do
    language_tag__83(
      rest,
      [
        <<x8::integer, x9::integer, x10::integer>>,
        <<x4::integer, x5::integer, x6::integer>>,
        <<x0::integer, x1::integer, x2::integer>>
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 11
    )
  end

  defp language_tag__82(rest, acc, stack, context, line, offset) do
    language_tag__81(rest, acc, stack, context, line, offset)
  end

  defp language_tag__83(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__75(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__84(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__82(rest, [], stack, context, line, offset)
  end

  defp language_tag__85(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 do
    language_tag__86(
      rest,
      [language_subtags: [<<x0::integer, x1::integer, x2::integer>>]] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__85(rest, acc, stack, context, line, offset) do
    language_tag__84(rest, acc, stack, context, line, offset)
  end

  defp language_tag__86(rest, acc, stack, context, line, offset) do
    language_tag__87(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__87(rest, acc, stack, context, line, offset) do
    language_tag__88(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__88(rest, acc, stack, context, line, offset) do
    language_tag__90(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__90(rest, acc, stack, context, line, offset) do
    language_tag__95(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__92(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__93(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__92(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__89(rest, acc, stack, context, line, offset)
  end

  defp language_tag__93(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__91(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__94(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__92(rest, [], stack, context, line, offset)
  end

  defp language_tag__95(rest, acc, stack, context, line, offset) do
    language_tag__96(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__96(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__97(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__96(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__94(rest, acc, stack, context, line, offset)
  end

  defp language_tag__97(rest, acc, stack, context, line, offset) do
    language_tag__99(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__99(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__100(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__99(rest, acc, stack, context, line, offset) do
    language_tag__98(rest, acc, stack, context, line, offset)
  end

  defp language_tag__98(rest, acc, [_ | stack], context, line, offset) do
    language_tag__101(rest, acc, stack, context, line, offset)
  end

  defp language_tag__100(rest, acc, [1 | stack], context, line, offset) do
    language_tag__101(rest, acc, stack, context, line, offset)
  end

  defp language_tag__100(rest, acc, [count | stack], context, line, offset) do
    language_tag__99(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__101(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__102(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__102(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__91(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__91(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__103(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__103(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__84(rest, acc, stack, context, line, offset)
  end

  defp language_tag__89(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__104(rest, acc, stack, context, line, offset)
  end

  defp language_tag__104(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__105(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__104(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__84(rest, acc, stack, context, line, offset)
  end

  defp language_tag__105(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__106(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__106(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__75(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__107(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__85(rest, [], stack, context, line, offset)
  end

  defp language_tag__108(
         <<x0, x1, x2, x3, x4, x5, x6, x7, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 do
    language_tag__109(
      rest,
      [
        language_subtags: [
          <<x0::integer, x1::integer, x2::integer>>,
          <<x4::integer, x5::integer, x6::integer>>
        ]
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 8
    )
  end

  defp language_tag__108(rest, acc, stack, context, line, offset) do
    language_tag__107(rest, acc, stack, context, line, offset)
  end

  defp language_tag__109(rest, acc, stack, context, line, offset) do
    language_tag__110(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__110(rest, acc, stack, context, line, offset) do
    language_tag__111(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__111(rest, acc, stack, context, line, offset) do
    language_tag__113(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__113(rest, acc, stack, context, line, offset) do
    language_tag__118(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__115(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__116(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__115(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__112(rest, acc, stack, context, line, offset)
  end

  defp language_tag__116(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__114(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__117(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__115(rest, [], stack, context, line, offset)
  end

  defp language_tag__118(rest, acc, stack, context, line, offset) do
    language_tag__119(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__119(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__120(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__119(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__117(rest, acc, stack, context, line, offset)
  end

  defp language_tag__120(rest, acc, stack, context, line, offset) do
    language_tag__122(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__122(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__123(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__122(rest, acc, stack, context, line, offset) do
    language_tag__121(rest, acc, stack, context, line, offset)
  end

  defp language_tag__121(rest, acc, [_ | stack], context, line, offset) do
    language_tag__124(rest, acc, stack, context, line, offset)
  end

  defp language_tag__123(rest, acc, [1 | stack], context, line, offset) do
    language_tag__124(rest, acc, stack, context, line, offset)
  end

  defp language_tag__123(rest, acc, [count | stack], context, line, offset) do
    language_tag__122(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__124(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__125(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__125(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__114(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__114(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__126(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__126(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__107(rest, acc, stack, context, line, offset)
  end

  defp language_tag__112(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__127(rest, acc, stack, context, line, offset)
  end

  defp language_tag__127(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__128(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__127(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__107(rest, acc, stack, context, line, offset)
  end

  defp language_tag__128(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__129(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__129(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__75(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__130(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__108(rest, [], stack, context, line, offset)
  end

  defp language_tag__131(
         <<x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 and
              ((x8 >= 97 and x8 <= 122) or (x8 >= 65 and x8 <= 90)) and
              ((x9 >= 97 and x9 <= 122) or (x9 >= 65 and x9 <= 90)) and
              ((x10 >= 97 and x10 <= 122) or (x10 >= 65 and x10 <= 90)) and x11 === 45 do
    language_tag__132(
      rest,
      [
        language_subtags: [
          <<x0::integer, x1::integer, x2::integer>>,
          <<x4::integer, x5::integer, x6::integer>>,
          <<x8::integer, x9::integer, x10::integer>>
        ]
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 12
    )
  end

  defp language_tag__131(rest, acc, stack, context, line, offset) do
    language_tag__130(rest, acc, stack, context, line, offset)
  end

  defp language_tag__132(rest, acc, stack, context, line, offset) do
    language_tag__133(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__133(rest, acc, stack, context, line, offset) do
    language_tag__134(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__134(rest, acc, stack, context, line, offset) do
    language_tag__136(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__136(rest, acc, stack, context, line, offset) do
    language_tag__141(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__138(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__139(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__138(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__135(rest, acc, stack, context, line, offset)
  end

  defp language_tag__139(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__137(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__140(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__138(rest, [], stack, context, line, offset)
  end

  defp language_tag__141(rest, acc, stack, context, line, offset) do
    language_tag__142(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__142(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__143(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__142(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__140(rest, acc, stack, context, line, offset)
  end

  defp language_tag__143(rest, acc, stack, context, line, offset) do
    language_tag__145(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__145(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__146(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__145(rest, acc, stack, context, line, offset) do
    language_tag__144(rest, acc, stack, context, line, offset)
  end

  defp language_tag__144(rest, acc, [_ | stack], context, line, offset) do
    language_tag__147(rest, acc, stack, context, line, offset)
  end

  defp language_tag__146(rest, acc, [1 | stack], context, line, offset) do
    language_tag__147(rest, acc, stack, context, line, offset)
  end

  defp language_tag__146(rest, acc, [count | stack], context, line, offset) do
    language_tag__145(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__147(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__148(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__148(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__137(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__137(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__149(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__149(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__130(rest, acc, stack, context, line, offset)
  end

  defp language_tag__135(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__150(rest, acc, stack, context, line, offset)
  end

  defp language_tag__150(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__151(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__150(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__130(rest, acc, stack, context, line, offset)
  end

  defp language_tag__151(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__152(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__152(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__75(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__153(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__131(rest, [], stack, context, line, offset)
  end

  defp language_tag__154(rest, acc, stack, context, line, offset) do
    language_tag__155(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__155(rest, acc, stack, context, line, offset) do
    language_tag__156(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__156(rest, acc, stack, context, line, offset) do
    language_tag__158(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__158(rest, acc, stack, context, line, offset) do
    language_tag__163(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__160(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__161(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__160(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__157(rest, acc, stack, context, line, offset)
  end

  defp language_tag__161(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__159(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__162(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__160(rest, [], stack, context, line, offset)
  end

  defp language_tag__163(rest, acc, stack, context, line, offset) do
    language_tag__164(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__164(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__165(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__164(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__162(rest, acc, stack, context, line, offset)
  end

  defp language_tag__165(rest, acc, stack, context, line, offset) do
    language_tag__167(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__167(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__168(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__167(rest, acc, stack, context, line, offset) do
    language_tag__166(rest, acc, stack, context, line, offset)
  end

  defp language_tag__166(rest, acc, [_ | stack], context, line, offset) do
    language_tag__169(rest, acc, stack, context, line, offset)
  end

  defp language_tag__168(rest, acc, [1 | stack], context, line, offset) do
    language_tag__169(rest, acc, stack, context, line, offset)
  end

  defp language_tag__168(rest, acc, [count | stack], context, line, offset) do
    language_tag__167(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__169(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__170(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__170(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__159(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__159(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__171(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__171(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__153(rest, acc, stack, context, line, offset)
  end

  defp language_tag__157(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__172(rest, acc, stack, context, line, offset)
  end

  defp language_tag__172(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__173(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__172(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__153(rest, acc, stack, context, line, offset)
  end

  defp language_tag__173(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__174(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__174(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__75(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__75(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__53(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__53(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__42(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__175(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__43(rest, [], stack, context, line, offset)
  end

  defp language_tag__176(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__177(
      rest,
      [language: <<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__176(rest, acc, stack, context, line, offset) do
    language_tag__175(rest, acc, stack, context, line, offset)
  end

  defp language_tag__177(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__42(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__178(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__176(rest, [], stack, context, line, offset)
  end

  defp language_tag__179(rest, acc, stack, context, line, offset) do
    language_tag__180(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__180(rest, acc, stack, context, line, offset) do
    language_tag__181(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__181(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) do
    language_tag__182(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__181(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__178(rest, acc, stack, context, line, offset)
  end

  defp language_tag__182(rest, acc, stack, context, line, offset) do
    language_tag__184(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__184(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) do
    language_tag__185(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__184(rest, acc, stack, context, line, offset) do
    language_tag__183(rest, acc, stack, context, line, offset)
  end

  defp language_tag__183(rest, acc, [_ | stack], context, line, offset) do
    language_tag__186(rest, acc, stack, context, line, offset)
  end

  defp language_tag__185(rest, acc, [1 | stack], context, line, offset) do
    language_tag__186(rest, acc, stack, context, line, offset)
  end

  defp language_tag__185(rest, acc, [count | stack], context, line, offset) do
    language_tag__184(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__186(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__187(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__187(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__188(
      rest,
      [
        language:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__188(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__42(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__42(rest, acc, stack, context, line, offset) do
    language_tag__192(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__190(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__189(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__191(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__190(rest, [], stack, context, line, offset)
  end

  defp language_tag__192(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__193(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__192(rest, acc, stack, context, line, offset) do
    language_tag__191(rest, acc, stack, context, line, offset)
  end

  defp language_tag__193(rest, acc, stack, context, line, offset) do
    language_tag__194(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__194(rest, acc, stack, context, line, offset) do
    language_tag__195(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__195(rest, acc, stack, context, line, offset) do
    language_tag__197(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__197(rest, acc, stack, context, line, offset) do
    language_tag__202(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__199(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__200(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__199(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__196(rest, acc, stack, context, line, offset)
  end

  defp language_tag__200(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__198(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__201(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__199(rest, [], stack, context, line, offset)
  end

  defp language_tag__202(rest, acc, stack, context, line, offset) do
    language_tag__203(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__203(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__204(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__203(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__201(rest, acc, stack, context, line, offset)
  end

  defp language_tag__204(rest, acc, stack, context, line, offset) do
    language_tag__206(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__206(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__207(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__206(rest, acc, stack, context, line, offset) do
    language_tag__205(rest, acc, stack, context, line, offset)
  end

  defp language_tag__205(rest, acc, [_ | stack], context, line, offset) do
    language_tag__208(rest, acc, stack, context, line, offset)
  end

  defp language_tag__207(rest, acc, [1 | stack], context, line, offset) do
    language_tag__208(rest, acc, stack, context, line, offset)
  end

  defp language_tag__207(rest, acc, [count | stack], context, line, offset) do
    language_tag__206(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__208(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__209(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__209(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__198(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__198(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__210(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__210(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__191(rest, acc, stack, context, line, offset)
  end

  defp language_tag__196(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__211(rest, acc, stack, context, line, offset)
  end

  defp language_tag__211(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__212(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__211(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__191(rest, acc, stack, context, line, offset)
  end

  defp language_tag__212(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__213(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__213(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__189(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__189(rest, acc, stack, context, line, offset) do
    language_tag__217(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__215(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__214(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__216(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__215(rest, [], stack, context, line, offset)
  end

  defp language_tag__217(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__218(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__217(rest, acc, stack, context, line, offset) do
    language_tag__216(rest, acc, stack, context, line, offset)
  end

  defp language_tag__218(rest, acc, stack, context, line, offset) do
    language_tag__219(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__219(rest, acc, stack, context, line, offset) do
    language_tag__220(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__220(rest, acc, stack, context, line, offset) do
    language_tag__222(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__222(rest, acc, stack, context, line, offset) do
    language_tag__227(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__224(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__225(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__224(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__221(rest, acc, stack, context, line, offset)
  end

  defp language_tag__225(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__223(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__226(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__224(rest, [], stack, context, line, offset)
  end

  defp language_tag__227(rest, acc, stack, context, line, offset) do
    language_tag__228(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__228(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__229(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__228(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__226(rest, acc, stack, context, line, offset)
  end

  defp language_tag__229(rest, acc, stack, context, line, offset) do
    language_tag__231(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__231(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__232(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__231(rest, acc, stack, context, line, offset) do
    language_tag__230(rest, acc, stack, context, line, offset)
  end

  defp language_tag__230(rest, acc, [_ | stack], context, line, offset) do
    language_tag__233(rest, acc, stack, context, line, offset)
  end

  defp language_tag__232(rest, acc, [1 | stack], context, line, offset) do
    language_tag__233(rest, acc, stack, context, line, offset)
  end

  defp language_tag__232(rest, acc, [count | stack], context, line, offset) do
    language_tag__231(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__233(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__234(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__234(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__223(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__223(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__235(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__235(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__216(rest, acc, stack, context, line, offset)
  end

  defp language_tag__221(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__236(rest, acc, stack, context, line, offset)
  end

  defp language_tag__236(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) do
    language_tag__237(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp language_tag__236(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) do
    language_tag__237(
      rest,
      [x2 - 48 + (x1 - 48) * 10 + (x0 - 48) * 100] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__236(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__216(rest, acc, stack, context, line, offset)
  end

  defp language_tag__237(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__238(
      rest,
      [
        territory:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__238(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__214(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__214(rest, acc, stack, context, line, offset) do
    language_tag__240(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__240(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__241(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__240(rest, acc, stack, context, line, offset) do
    language_tag__239(rest, acc, stack, context, line, offset)
  end

  defp language_tag__241(rest, acc, stack, context, line, offset) do
    language_tag__242(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__242(rest, acc, stack, context, line, offset) do
    language_tag__247(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__244(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__245(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__244(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__239(rest, acc, stack, context, line, offset)
  end

  defp language_tag__245(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__243(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__246(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__244(rest, [], stack, context, line, offset)
  end

  defp language_tag__247(rest, acc, stack, context, line, offset) do
    language_tag__248(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__248(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__249(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__248(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__246(rest, acc, stack, context, line, offset)
  end

  defp language_tag__249(rest, acc, stack, context, line, offset) do
    language_tag__251(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__251(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__252(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__251(rest, acc, stack, context, line, offset) do
    language_tag__250(rest, acc, stack, context, line, offset)
  end

  defp language_tag__250(rest, acc, [_ | stack], context, line, offset) do
    language_tag__253(rest, acc, stack, context, line, offset)
  end

  defp language_tag__252(rest, acc, [1 | stack], context, line, offset) do
    language_tag__253(rest, acc, stack, context, line, offset)
  end

  defp language_tag__252(rest, acc, [count | stack], context, line, offset) do
    language_tag__251(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__253(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__254(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__254(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__243(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__243(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__255(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__239(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__256(rest, acc, stack, context, line, offset)
  end

  defp language_tag__255(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__240(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__256(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__257(
      rest,
      [collapse_variants(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__257(rest, acc, stack, context, line, offset) do
    language_tag__261(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__259(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__258(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__260(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__259(rest, [], stack, context, line, offset)
  end

  defp language_tag__261(rest, acc, stack, context, line, offset) do
    language_tag__262(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__262(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__263(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__262(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__260(rest, acc, stack, context, line, offset)
  end

  defp language_tag__263(rest, acc, stack, context, line, offset) do
    language_tag__288(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__265(rest, acc, stack, context, line, offset) do
    language_tag__266(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__266(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 === 120 or x0 === 88) and x1 === 45 do
    language_tag__267(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp language_tag__266(rest, _acc, stack, context, line, offset) do
    [_, _, _, acc | stack] = stack
    language_tag__260(rest, acc, stack, context, line, offset)
  end

  defp language_tag__267(rest, acc, stack, context, line, offset) do
    language_tag__268(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__268(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__269(
      rest,
      [<<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp language_tag__268(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    language_tag__260(rest, acc, stack, context, line, offset)
  end

  defp language_tag__269(rest, acc, stack, context, line, offset) do
    language_tag__271(rest, acc, [7 | stack], context, line, offset)
  end

  defp language_tag__271(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__272(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__271(rest, acc, stack, context, line, offset) do
    language_tag__270(rest, acc, stack, context, line, offset)
  end

  defp language_tag__270(rest, acc, [_ | stack], context, line, offset) do
    language_tag__273(rest, acc, stack, context, line, offset)
  end

  defp language_tag__272(rest, acc, [1 | stack], context, line, offset) do
    language_tag__273(rest, acc, stack, context, line, offset)
  end

  defp language_tag__272(rest, acc, [count | stack], context, line, offset) do
    language_tag__271(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__273(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__274(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__274(rest, acc, stack, context, line, offset) do
    language_tag__276(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__276(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__277(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__276(rest, acc, stack, context, line, offset) do
    language_tag__275(rest, acc, stack, context, line, offset)
  end

  defp language_tag__277(rest, acc, stack, context, line, offset) do
    language_tag__278(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__278(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__279(
      rest,
      [<<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp language_tag__278(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__275(rest, acc, stack, context, line, offset)
  end

  defp language_tag__279(rest, acc, stack, context, line, offset) do
    language_tag__281(rest, acc, [7 | stack], context, line, offset)
  end

  defp language_tag__281(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__282(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__281(rest, acc, stack, context, line, offset) do
    language_tag__280(rest, acc, stack, context, line, offset)
  end

  defp language_tag__280(rest, acc, [_ | stack], context, line, offset) do
    language_tag__283(rest, acc, stack, context, line, offset)
  end

  defp language_tag__282(rest, acc, [1 | stack], context, line, offset) do
    language_tag__283(rest, acc, stack, context, line, offset)
  end

  defp language_tag__282(rest, acc, [count | stack], context, line, offset) do
    language_tag__281(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__283(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__284(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__275(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__285(rest, acc, stack, context, line, offset)
  end

  defp language_tag__284(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__276(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__285(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__286(
      rest,
      [private_use: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__286(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__264(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__287(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__265(rest, [], stack, context, line, offset)
  end

  defp language_tag__288(rest, acc, stack, context, line, offset) do
    language_tag__289(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__289(rest, acc, stack, context, line, offset) do
    language_tag__583(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__291(rest, acc, stack, context, line, offset) do
    language_tag__292(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__292(rest, acc, stack, context, line, offset) do
    language_tag__293(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__293(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 48 and x0 <= 57) or (x0 >= 97 and x0 <= 115) or (x0 >= 65 and x0 <= 83) or
              (x0 >= 118 and x0 <= 119) or (x0 >= 86 and x0 <= 87) or (x0 >= 121 and x0 <= 122) or
              (x0 >= 89 and x0 <= 90) do
    language_tag__294(
      rest,
      [type: <<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp language_tag__293(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    language_tag__287(rest, acc, stack, context, line, offset)
  end

  defp language_tag__294(rest, acc, stack, context, line, offset) do
    language_tag__295(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__295(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__296(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__295(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, _, acc | stack] = stack
    language_tag__287(rest, acc, stack, context, line, offset)
  end

  defp language_tag__296(rest, acc, stack, context, line, offset) do
    language_tag__297(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__297(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) do
    language_tag__298(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp language_tag__297(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, _, _, acc | stack] = stack
    language_tag__287(rest, acc, stack, context, line, offset)
  end

  defp language_tag__298(rest, acc, stack, context, line, offset) do
    language_tag__300(rest, acc, [6 | stack], context, line, offset)
  end

  defp language_tag__300(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__301(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__300(rest, acc, stack, context, line, offset) do
    language_tag__299(rest, acc, stack, context, line, offset)
  end

  defp language_tag__299(rest, acc, [_ | stack], context, line, offset) do
    language_tag__302(rest, acc, stack, context, line, offset)
  end

  defp language_tag__301(rest, acc, [1 | stack], context, line, offset) do
    language_tag__302(rest, acc, stack, context, line, offset)
  end

  defp language_tag__301(rest, acc, [count | stack], context, line, offset) do
    language_tag__300(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__302(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__303(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__303(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__304(
      rest,
      [
        attribute:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__304(rest, acc, stack, context, line, offset) do
    language_tag__306(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__306(rest, acc, stack, context, line, offset) do
    language_tag__307(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__307(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__308(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__307(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__305(rest, acc, stack, context, line, offset)
  end

  defp language_tag__308(rest, acc, stack, context, line, offset) do
    language_tag__309(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__309(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) do
    language_tag__310(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp language_tag__309(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__305(rest, acc, stack, context, line, offset)
  end

  defp language_tag__310(rest, acc, stack, context, line, offset) do
    language_tag__312(rest, acc, [6 | stack], context, line, offset)
  end

  defp language_tag__312(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__313(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__312(rest, acc, stack, context, line, offset) do
    language_tag__311(rest, acc, stack, context, line, offset)
  end

  defp language_tag__311(rest, acc, [_ | stack], context, line, offset) do
    language_tag__314(rest, acc, stack, context, line, offset)
  end

  defp language_tag__313(rest, acc, [1 | stack], context, line, offset) do
    language_tag__314(rest, acc, stack, context, line, offset)
  end

  defp language_tag__313(rest, acc, [count | stack], context, line, offset) do
    language_tag__312(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__314(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__315(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__315(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__316(
      rest,
      [
        attribute:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__305(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__317(rest, acc, stack, context, line, offset)
  end

  defp language_tag__316(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__306(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__317(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__318(
      rest,
      [collapse_extension(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__318(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__319(
      rest,
      [
        extension:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__319(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__290(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__320(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__291(rest, [], stack, context, line, offset)
  end

  defp language_tag__321(rest, acc, stack, context, line, offset) do
    language_tag__322(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__322(rest, acc, stack, context, line, offset) do
    language_tag__323(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__323(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 116 or x0 === 84 do
    language_tag__324(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__323(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__320(rest, acc, stack, context, line, offset)
  end

  defp language_tag__324(rest, acc, stack, context, line, offset) do
    language_tag__328(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__326(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__325(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__327(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__326(rest, [], stack, context, line, offset)
  end

  defp language_tag__328(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__329(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__328(rest, acc, stack, context, line, offset) do
    language_tag__327(rest, acc, stack, context, line, offset)
  end

  defp language_tag__329(rest, acc, stack, context, line, offset) do
    language_tag__330(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__330(rest, acc, stack, context, line, offset) do
    language_tag__468(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__332(rest, acc, stack, context, line, offset) do
    language_tag__333(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__333(rest, acc, stack, context, line, offset) do
    language_tag__334(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__334(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) do
    language_tag__335(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp language_tag__334(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    language_tag__327(rest, acc, stack, context, line, offset)
  end

  defp language_tag__335(rest, acc, stack, context, line, offset) do
    language_tag__337(rest, acc, [1 | stack], context, line, offset)
  end

  defp language_tag__337(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) do
    language_tag__338(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__337(rest, acc, stack, context, line, offset) do
    language_tag__336(rest, acc, stack, context, line, offset)
  end

  defp language_tag__336(rest, acc, [_ | stack], context, line, offset) do
    language_tag__339(rest, acc, stack, context, line, offset)
  end

  defp language_tag__338(rest, acc, [1 | stack], context, line, offset) do
    language_tag__339(rest, acc, stack, context, line, offset)
  end

  defp language_tag__338(rest, acc, [count | stack], context, line, offset) do
    language_tag__337(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__339(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__340(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__340(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__341(
      rest,
      [
        language:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__341(rest, acc, stack, context, line, offset) do
    language_tag__345(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__343(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__342(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__344(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__343(rest, [], stack, context, line, offset)
  end

  defp language_tag__345(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__346(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__345(rest, acc, stack, context, line, offset) do
    language_tag__344(rest, acc, stack, context, line, offset)
  end

  defp language_tag__346(rest, acc, stack, context, line, offset) do
    language_tag__347(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__347(rest, acc, stack, context, line, offset) do
    language_tag__349(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__349(rest, acc, stack, context, line, offset) do
    language_tag__354(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__351(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__352(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__351(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__348(rest, acc, stack, context, line, offset)
  end

  defp language_tag__352(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__350(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__353(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__351(rest, [], stack, context, line, offset)
  end

  defp language_tag__354(rest, acc, stack, context, line, offset) do
    language_tag__355(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__355(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__356(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__355(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__353(rest, acc, stack, context, line, offset)
  end

  defp language_tag__356(rest, acc, stack, context, line, offset) do
    language_tag__358(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__358(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__359(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__358(rest, acc, stack, context, line, offset) do
    language_tag__357(rest, acc, stack, context, line, offset)
  end

  defp language_tag__357(rest, acc, [_ | stack], context, line, offset) do
    language_tag__360(rest, acc, stack, context, line, offset)
  end

  defp language_tag__359(rest, acc, [1 | stack], context, line, offset) do
    language_tag__360(rest, acc, stack, context, line, offset)
  end

  defp language_tag__359(rest, acc, [count | stack], context, line, offset) do
    language_tag__358(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__360(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__361(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__361(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__350(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__350(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__362(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__362(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__344(rest, acc, stack, context, line, offset)
  end

  defp language_tag__348(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__363(rest, acc, stack, context, line, offset)
  end

  defp language_tag__363(rest, acc, stack, context, line, offset) do
    language_tag__443(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__365(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) do
    language_tag__366(
      rest,
      [language_subtags: [<<x0::integer, x1::integer, x2::integer>>]] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__365(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__344(rest, acc, stack, context, line, offset)
  end

  defp language_tag__366(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__364(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__367(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__365(rest, [], stack, context, line, offset)
  end

  defp language_tag__368(
         <<x0, x1, x2, x3, x4, x5, x6, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) do
    language_tag__369(
      rest,
      [<<x4::integer, x5::integer, x6::integer>>, <<x0::integer, x1::integer, x2::integer>>] ++
        acc,
      stack,
      context,
      comb__line,
      comb__offset + 7
    )
  end

  defp language_tag__368(rest, acc, stack, context, line, offset) do
    language_tag__367(rest, acc, stack, context, line, offset)
  end

  defp language_tag__369(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__364(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__370(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__368(rest, [], stack, context, line, offset)
  end

  defp language_tag__371(
         <<x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 and
              ((x8 >= 97 and x8 <= 122) or (x8 >= 65 and x8 <= 90)) and
              ((x9 >= 97 and x9 <= 122) or (x9 >= 65 and x9 <= 90)) and
              ((x10 >= 97 and x10 <= 122) or (x10 >= 65 and x10 <= 90)) do
    language_tag__372(
      rest,
      [
        <<x8::integer, x9::integer, x10::integer>>,
        <<x4::integer, x5::integer, x6::integer>>,
        <<x0::integer, x1::integer, x2::integer>>
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 11
    )
  end

  defp language_tag__371(rest, acc, stack, context, line, offset) do
    language_tag__370(rest, acc, stack, context, line, offset)
  end

  defp language_tag__372(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__364(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__373(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__371(rest, [], stack, context, line, offset)
  end

  defp language_tag__374(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 do
    language_tag__375(
      rest,
      [language_subtags: [<<x0::integer, x1::integer, x2::integer>>]] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__374(rest, acc, stack, context, line, offset) do
    language_tag__373(rest, acc, stack, context, line, offset)
  end

  defp language_tag__375(rest, acc, stack, context, line, offset) do
    language_tag__376(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__376(rest, acc, stack, context, line, offset) do
    language_tag__377(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__377(rest, acc, stack, context, line, offset) do
    language_tag__379(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__379(rest, acc, stack, context, line, offset) do
    language_tag__384(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__381(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__382(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__381(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__378(rest, acc, stack, context, line, offset)
  end

  defp language_tag__382(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__380(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__383(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__381(rest, [], stack, context, line, offset)
  end

  defp language_tag__384(rest, acc, stack, context, line, offset) do
    language_tag__385(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__385(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__386(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__385(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__383(rest, acc, stack, context, line, offset)
  end

  defp language_tag__386(rest, acc, stack, context, line, offset) do
    language_tag__388(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__388(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__389(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__388(rest, acc, stack, context, line, offset) do
    language_tag__387(rest, acc, stack, context, line, offset)
  end

  defp language_tag__387(rest, acc, [_ | stack], context, line, offset) do
    language_tag__390(rest, acc, stack, context, line, offset)
  end

  defp language_tag__389(rest, acc, [1 | stack], context, line, offset) do
    language_tag__390(rest, acc, stack, context, line, offset)
  end

  defp language_tag__389(rest, acc, [count | stack], context, line, offset) do
    language_tag__388(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__390(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__391(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__391(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__380(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__380(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__392(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__392(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__373(rest, acc, stack, context, line, offset)
  end

  defp language_tag__378(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__393(rest, acc, stack, context, line, offset)
  end

  defp language_tag__393(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__394(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__393(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__373(rest, acc, stack, context, line, offset)
  end

  defp language_tag__394(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__395(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__395(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__364(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__396(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__374(rest, [], stack, context, line, offset)
  end

  defp language_tag__397(
         <<x0, x1, x2, x3, x4, x5, x6, x7, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 do
    language_tag__398(
      rest,
      [
        language_subtags: [
          <<x0::integer, x1::integer, x2::integer>>,
          <<x4::integer, x5::integer, x6::integer>>
        ]
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 8
    )
  end

  defp language_tag__397(rest, acc, stack, context, line, offset) do
    language_tag__396(rest, acc, stack, context, line, offset)
  end

  defp language_tag__398(rest, acc, stack, context, line, offset) do
    language_tag__399(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__399(rest, acc, stack, context, line, offset) do
    language_tag__400(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__400(rest, acc, stack, context, line, offset) do
    language_tag__402(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__402(rest, acc, stack, context, line, offset) do
    language_tag__407(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__404(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__405(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__404(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__401(rest, acc, stack, context, line, offset)
  end

  defp language_tag__405(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__403(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__406(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__404(rest, [], stack, context, line, offset)
  end

  defp language_tag__407(rest, acc, stack, context, line, offset) do
    language_tag__408(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__408(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__409(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__408(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__406(rest, acc, stack, context, line, offset)
  end

  defp language_tag__409(rest, acc, stack, context, line, offset) do
    language_tag__411(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__411(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__412(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__411(rest, acc, stack, context, line, offset) do
    language_tag__410(rest, acc, stack, context, line, offset)
  end

  defp language_tag__410(rest, acc, [_ | stack], context, line, offset) do
    language_tag__413(rest, acc, stack, context, line, offset)
  end

  defp language_tag__412(rest, acc, [1 | stack], context, line, offset) do
    language_tag__413(rest, acc, stack, context, line, offset)
  end

  defp language_tag__412(rest, acc, [count | stack], context, line, offset) do
    language_tag__411(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__413(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__414(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__414(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__403(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__403(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__415(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__415(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__396(rest, acc, stack, context, line, offset)
  end

  defp language_tag__401(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__416(rest, acc, stack, context, line, offset)
  end

  defp language_tag__416(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__417(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__416(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__396(rest, acc, stack, context, line, offset)
  end

  defp language_tag__417(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__418(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__418(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__364(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__419(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__397(rest, [], stack, context, line, offset)
  end

  defp language_tag__420(
         <<x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 and
              ((x8 >= 97 and x8 <= 122) or (x8 >= 65 and x8 <= 90)) and
              ((x9 >= 97 and x9 <= 122) or (x9 >= 65 and x9 <= 90)) and
              ((x10 >= 97 and x10 <= 122) or (x10 >= 65 and x10 <= 90)) and x11 === 45 do
    language_tag__421(
      rest,
      [
        language_subtags: [
          <<x0::integer, x1::integer, x2::integer>>,
          <<x4::integer, x5::integer, x6::integer>>,
          <<x8::integer, x9::integer, x10::integer>>
        ]
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 12
    )
  end

  defp language_tag__420(rest, acc, stack, context, line, offset) do
    language_tag__419(rest, acc, stack, context, line, offset)
  end

  defp language_tag__421(rest, acc, stack, context, line, offset) do
    language_tag__422(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__422(rest, acc, stack, context, line, offset) do
    language_tag__423(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__423(rest, acc, stack, context, line, offset) do
    language_tag__425(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__425(rest, acc, stack, context, line, offset) do
    language_tag__430(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__427(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__428(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__427(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__424(rest, acc, stack, context, line, offset)
  end

  defp language_tag__428(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__426(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__429(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__427(rest, [], stack, context, line, offset)
  end

  defp language_tag__430(rest, acc, stack, context, line, offset) do
    language_tag__431(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__431(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__432(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__431(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__429(rest, acc, stack, context, line, offset)
  end

  defp language_tag__432(rest, acc, stack, context, line, offset) do
    language_tag__434(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__434(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__435(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__434(rest, acc, stack, context, line, offset) do
    language_tag__433(rest, acc, stack, context, line, offset)
  end

  defp language_tag__433(rest, acc, [_ | stack], context, line, offset) do
    language_tag__436(rest, acc, stack, context, line, offset)
  end

  defp language_tag__435(rest, acc, [1 | stack], context, line, offset) do
    language_tag__436(rest, acc, stack, context, line, offset)
  end

  defp language_tag__435(rest, acc, [count | stack], context, line, offset) do
    language_tag__434(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__436(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__437(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__437(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__426(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__426(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__438(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__438(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__419(rest, acc, stack, context, line, offset)
  end

  defp language_tag__424(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__439(rest, acc, stack, context, line, offset)
  end

  defp language_tag__439(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__440(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__439(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__419(rest, acc, stack, context, line, offset)
  end

  defp language_tag__440(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__441(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__441(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__364(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__442(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__420(rest, [], stack, context, line, offset)
  end

  defp language_tag__443(rest, acc, stack, context, line, offset) do
    language_tag__444(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__444(rest, acc, stack, context, line, offset) do
    language_tag__445(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__445(rest, acc, stack, context, line, offset) do
    language_tag__447(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__447(rest, acc, stack, context, line, offset) do
    language_tag__452(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__449(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__450(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__449(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__446(rest, acc, stack, context, line, offset)
  end

  defp language_tag__450(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__448(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__451(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__449(rest, [], stack, context, line, offset)
  end

  defp language_tag__452(rest, acc, stack, context, line, offset) do
    language_tag__453(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__453(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__454(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__453(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__451(rest, acc, stack, context, line, offset)
  end

  defp language_tag__454(rest, acc, stack, context, line, offset) do
    language_tag__456(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__456(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__457(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__456(rest, acc, stack, context, line, offset) do
    language_tag__455(rest, acc, stack, context, line, offset)
  end

  defp language_tag__455(rest, acc, [_ | stack], context, line, offset) do
    language_tag__458(rest, acc, stack, context, line, offset)
  end

  defp language_tag__457(rest, acc, [1 | stack], context, line, offset) do
    language_tag__458(rest, acc, stack, context, line, offset)
  end

  defp language_tag__457(rest, acc, [count | stack], context, line, offset) do
    language_tag__456(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__458(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__459(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__459(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__448(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__448(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__460(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__460(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__442(rest, acc, stack, context, line, offset)
  end

  defp language_tag__446(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__461(rest, acc, stack, context, line, offset)
  end

  defp language_tag__461(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__462(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__461(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__442(rest, acc, stack, context, line, offset)
  end

  defp language_tag__462(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__463(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__463(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__364(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__364(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__342(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__342(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__331(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__464(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__332(rest, [], stack, context, line, offset)
  end

  defp language_tag__465(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__466(
      rest,
      [language: <<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__465(rest, acc, stack, context, line, offset) do
    language_tag__464(rest, acc, stack, context, line, offset)
  end

  defp language_tag__466(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__331(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__467(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__465(rest, [], stack, context, line, offset)
  end

  defp language_tag__468(rest, acc, stack, context, line, offset) do
    language_tag__469(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__469(rest, acc, stack, context, line, offset) do
    language_tag__470(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__470(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) do
    language_tag__471(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__470(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__467(rest, acc, stack, context, line, offset)
  end

  defp language_tag__471(rest, acc, stack, context, line, offset) do
    language_tag__473(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__473(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) do
    language_tag__474(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__473(rest, acc, stack, context, line, offset) do
    language_tag__472(rest, acc, stack, context, line, offset)
  end

  defp language_tag__472(rest, acc, [_ | stack], context, line, offset) do
    language_tag__475(rest, acc, stack, context, line, offset)
  end

  defp language_tag__474(rest, acc, [1 | stack], context, line, offset) do
    language_tag__475(rest, acc, stack, context, line, offset)
  end

  defp language_tag__474(rest, acc, [count | stack], context, line, offset) do
    language_tag__473(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__475(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__476(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__476(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__477(
      rest,
      [
        language:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__477(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__331(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__331(rest, acc, stack, context, line, offset) do
    language_tag__481(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__479(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__478(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__480(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__479(rest, [], stack, context, line, offset)
  end

  defp language_tag__481(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__482(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__481(rest, acc, stack, context, line, offset) do
    language_tag__480(rest, acc, stack, context, line, offset)
  end

  defp language_tag__482(rest, acc, stack, context, line, offset) do
    language_tag__483(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__483(rest, acc, stack, context, line, offset) do
    language_tag__484(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__484(rest, acc, stack, context, line, offset) do
    language_tag__486(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__486(rest, acc, stack, context, line, offset) do
    language_tag__491(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__488(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__489(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__488(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__485(rest, acc, stack, context, line, offset)
  end

  defp language_tag__489(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__487(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__490(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__488(rest, [], stack, context, line, offset)
  end

  defp language_tag__491(rest, acc, stack, context, line, offset) do
    language_tag__492(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__492(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__493(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__492(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__490(rest, acc, stack, context, line, offset)
  end

  defp language_tag__493(rest, acc, stack, context, line, offset) do
    language_tag__495(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__495(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__496(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__495(rest, acc, stack, context, line, offset) do
    language_tag__494(rest, acc, stack, context, line, offset)
  end

  defp language_tag__494(rest, acc, [_ | stack], context, line, offset) do
    language_tag__497(rest, acc, stack, context, line, offset)
  end

  defp language_tag__496(rest, acc, [1 | stack], context, line, offset) do
    language_tag__497(rest, acc, stack, context, line, offset)
  end

  defp language_tag__496(rest, acc, [count | stack], context, line, offset) do
    language_tag__495(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__497(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__498(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__498(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__487(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__487(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__499(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__499(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__480(rest, acc, stack, context, line, offset)
  end

  defp language_tag__485(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__500(rest, acc, stack, context, line, offset)
  end

  defp language_tag__500(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__501(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__500(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__480(rest, acc, stack, context, line, offset)
  end

  defp language_tag__501(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__502(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__502(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__478(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__478(rest, acc, stack, context, line, offset) do
    language_tag__506(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__504(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__503(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__505(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__504(rest, [], stack, context, line, offset)
  end

  defp language_tag__506(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__507(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__506(rest, acc, stack, context, line, offset) do
    language_tag__505(rest, acc, stack, context, line, offset)
  end

  defp language_tag__507(rest, acc, stack, context, line, offset) do
    language_tag__508(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__508(rest, acc, stack, context, line, offset) do
    language_tag__509(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__509(rest, acc, stack, context, line, offset) do
    language_tag__511(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__511(rest, acc, stack, context, line, offset) do
    language_tag__516(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__513(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__514(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__513(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__510(rest, acc, stack, context, line, offset)
  end

  defp language_tag__514(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__512(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__515(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__513(rest, [], stack, context, line, offset)
  end

  defp language_tag__516(rest, acc, stack, context, line, offset) do
    language_tag__517(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__517(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__518(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__517(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__515(rest, acc, stack, context, line, offset)
  end

  defp language_tag__518(rest, acc, stack, context, line, offset) do
    language_tag__520(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__520(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__521(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__520(rest, acc, stack, context, line, offset) do
    language_tag__519(rest, acc, stack, context, line, offset)
  end

  defp language_tag__519(rest, acc, [_ | stack], context, line, offset) do
    language_tag__522(rest, acc, stack, context, line, offset)
  end

  defp language_tag__521(rest, acc, [1 | stack], context, line, offset) do
    language_tag__522(rest, acc, stack, context, line, offset)
  end

  defp language_tag__521(rest, acc, [count | stack], context, line, offset) do
    language_tag__520(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__522(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__523(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__523(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__512(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__512(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__524(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__524(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__505(rest, acc, stack, context, line, offset)
  end

  defp language_tag__510(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__525(rest, acc, stack, context, line, offset)
  end

  defp language_tag__525(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) do
    language_tag__526(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp language_tag__525(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) do
    language_tag__526(
      rest,
      [x2 - 48 + (x1 - 48) * 10 + (x0 - 48) * 100] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__525(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__505(rest, acc, stack, context, line, offset)
  end

  defp language_tag__526(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__527(
      rest,
      [
        territory:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__527(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__503(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__503(rest, acc, stack, context, line, offset) do
    language_tag__529(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__529(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__530(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__529(rest, acc, stack, context, line, offset) do
    language_tag__528(rest, acc, stack, context, line, offset)
  end

  defp language_tag__530(rest, acc, stack, context, line, offset) do
    language_tag__531(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__531(rest, acc, stack, context, line, offset) do
    language_tag__536(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__533(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__534(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__533(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__528(rest, acc, stack, context, line, offset)
  end

  defp language_tag__534(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__532(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__535(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__533(rest, [], stack, context, line, offset)
  end

  defp language_tag__536(rest, acc, stack, context, line, offset) do
    language_tag__537(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__537(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__538(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__537(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__535(rest, acc, stack, context, line, offset)
  end

  defp language_tag__538(rest, acc, stack, context, line, offset) do
    language_tag__540(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__540(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__541(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__540(rest, acc, stack, context, line, offset) do
    language_tag__539(rest, acc, stack, context, line, offset)
  end

  defp language_tag__539(rest, acc, [_ | stack], context, line, offset) do
    language_tag__542(rest, acc, stack, context, line, offset)
  end

  defp language_tag__541(rest, acc, [1 | stack], context, line, offset) do
    language_tag__542(rest, acc, stack, context, line, offset)
  end

  defp language_tag__541(rest, acc, [count | stack], context, line, offset) do
    language_tag__540(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__542(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__543(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__543(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__532(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__532(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__544(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__528(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__545(rest, acc, stack, context, line, offset)
  end

  defp language_tag__544(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__529(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__545(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__546(
      rest,
      [collapse_variants(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__546(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__325(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__325(rest, acc, stack, context, line, offset) do
    language_tag__547(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__547(rest, acc, stack, context, line, offset) do
    language_tag__549(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__549(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__550(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__549(rest, acc, stack, context, line, offset) do
    language_tag__548(rest, acc, stack, context, line, offset)
  end

  defp language_tag__550(rest, acc, stack, context, line, offset) do
    language_tag__554(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__552(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__551(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__553(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__552(rest, [], stack, context, line, offset)
  end

  defp language_tag__554(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__555(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__554(rest, acc, stack, context, line, offset) do
    language_tag__553(rest, acc, stack, context, line, offset)
  end

  defp language_tag__555(rest, acc, stack, context, line, offset) do
    language_tag__556(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__556(rest, acc, stack, context, line, offset) do
    language_tag__557(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__557(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__558(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__557(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__553(rest, acc, stack, context, line, offset)
  end

  defp language_tag__558(rest, acc, stack, context, line, offset) do
    language_tag__560(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__560(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__561(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__560(rest, acc, stack, context, line, offset) do
    language_tag__559(rest, acc, stack, context, line, offset)
  end

  defp language_tag__559(rest, acc, [_ | stack], context, line, offset) do
    language_tag__562(rest, acc, stack, context, line, offset)
  end

  defp language_tag__561(rest, acc, [1 | stack], context, line, offset) do
    language_tag__562(rest, acc, stack, context, line, offset)
  end

  defp language_tag__561(rest, acc, [count | stack], context, line, offset) do
    language_tag__560(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__562(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__563(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__563(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__564(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__564(rest, acc, stack, context, line, offset) do
    language_tag__566(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__566(rest, acc, stack, context, line, offset) do
    language_tag__567(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__567(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__568(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__567(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__565(rest, acc, stack, context, line, offset)
  end

  defp language_tag__568(rest, acc, stack, context, line, offset) do
    language_tag__569(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__569(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__570(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__569(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__565(rest, acc, stack, context, line, offset)
  end

  defp language_tag__570(rest, acc, stack, context, line, offset) do
    language_tag__572(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__572(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__573(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__572(rest, acc, stack, context, line, offset) do
    language_tag__571(rest, acc, stack, context, line, offset)
  end

  defp language_tag__571(rest, acc, [_ | stack], context, line, offset) do
    language_tag__574(rest, acc, stack, context, line, offset)
  end

  defp language_tag__573(rest, acc, [1 | stack], context, line, offset) do
    language_tag__574(rest, acc, stack, context, line, offset)
  end

  defp language_tag__573(rest, acc, [count | stack], context, line, offset) do
    language_tag__572(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__574(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__575(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__575(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__576(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__565(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__577(rest, acc, stack, context, line, offset)
  end

  defp language_tag__576(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__566(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__577(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__551(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__548(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__578(rest, acc, stack, context, line, offset)
  end

  defp language_tag__551(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__549(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__578(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__579(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__579(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__580(
      rest,
      [merge_langtag_and_transform(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__580(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__581(
      rest,
      [
        transform:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__581(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__290(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__582(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__321(rest, [], stack, context, line, offset)
  end

  defp language_tag__583(rest, acc, stack, context, line, offset) do
    language_tag__584(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__584(rest, acc, stack, context, line, offset) do
    language_tag__585(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__585(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 117 or x0 === 85 do
    language_tag__586(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__585(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__582(rest, acc, stack, context, line, offset)
  end

  defp language_tag__586(rest, acc, stack, context, line, offset) do
    language_tag__623(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__588(rest, acc, stack, context, line, offset) do
    language_tag__589(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__589(rest, acc, stack, context, line, offset) do
    language_tag__591(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__591(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__592(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__591(rest, acc, stack, context, line, offset) do
    language_tag__590(rest, acc, stack, context, line, offset)
  end

  defp language_tag__592(rest, acc, stack, context, line, offset) do
    language_tag__596(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__594(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__593(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__595(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__594(rest, [], stack, context, line, offset)
  end

  defp language_tag__596(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__597(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__596(rest, acc, stack, context, line, offset) do
    language_tag__595(rest, acc, stack, context, line, offset)
  end

  defp language_tag__597(rest, acc, stack, context, line, offset) do
    language_tag__598(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__598(rest, acc, stack, context, line, offset) do
    language_tag__599(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__599(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__600(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__599(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__595(rest, acc, stack, context, line, offset)
  end

  defp language_tag__600(rest, acc, stack, context, line, offset) do
    language_tag__602(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__602(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__603(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__602(rest, acc, stack, context, line, offset) do
    language_tag__601(rest, acc, stack, context, line, offset)
  end

  defp language_tag__601(rest, acc, [_ | stack], context, line, offset) do
    language_tag__604(rest, acc, stack, context, line, offset)
  end

  defp language_tag__603(rest, acc, [1 | stack], context, line, offset) do
    language_tag__604(rest, acc, stack, context, line, offset)
  end

  defp language_tag__603(rest, acc, [count | stack], context, line, offset) do
    language_tag__602(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__604(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__605(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__605(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__606(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__606(rest, acc, stack, context, line, offset) do
    language_tag__608(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__608(rest, acc, stack, context, line, offset) do
    language_tag__609(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__609(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__610(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__609(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__607(rest, acc, stack, context, line, offset)
  end

  defp language_tag__610(rest, acc, stack, context, line, offset) do
    language_tag__611(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__611(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__612(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__611(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__607(rest, acc, stack, context, line, offset)
  end

  defp language_tag__612(rest, acc, stack, context, line, offset) do
    language_tag__614(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__614(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__615(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__614(rest, acc, stack, context, line, offset) do
    language_tag__613(rest, acc, stack, context, line, offset)
  end

  defp language_tag__613(rest, acc, [_ | stack], context, line, offset) do
    language_tag__616(rest, acc, stack, context, line, offset)
  end

  defp language_tag__615(rest, acc, [1 | stack], context, line, offset) do
    language_tag__616(rest, acc, stack, context, line, offset)
  end

  defp language_tag__615(rest, acc, [count | stack], context, line, offset) do
    language_tag__614(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__616(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__617(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__617(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__618(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__607(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__619(rest, acc, stack, context, line, offset)
  end

  defp language_tag__618(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__608(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__619(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__593(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__590(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__620(rest, acc, stack, context, line, offset)
  end

  defp language_tag__593(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__591(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__620(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__621(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__621(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__587(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__622(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__588(rest, [], stack, context, line, offset)
  end

  defp language_tag__623(rest, acc, stack, context, line, offset) do
    language_tag__624(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__624(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__625(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__624(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__622(rest, acc, stack, context, line, offset)
  end

  defp language_tag__625(rest, acc, stack, context, line, offset) do
    language_tag__626(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__626(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__627(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__626(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__622(rest, acc, stack, context, line, offset)
  end

  defp language_tag__627(rest, acc, stack, context, line, offset) do
    language_tag__629(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__629(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__630(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__629(rest, acc, stack, context, line, offset) do
    language_tag__628(rest, acc, stack, context, line, offset)
  end

  defp language_tag__628(rest, acc, [_ | stack], context, line, offset) do
    language_tag__631(rest, acc, stack, context, line, offset)
  end

  defp language_tag__630(rest, acc, [1 | stack], context, line, offset) do
    language_tag__631(rest, acc, stack, context, line, offset)
  end

  defp language_tag__630(rest, acc, [count | stack], context, line, offset) do
    language_tag__629(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__631(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__632(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__632(rest, acc, stack, context, line, offset) do
    language_tag__634(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__634(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__635(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__634(rest, acc, stack, context, line, offset) do
    language_tag__633(rest, acc, stack, context, line, offset)
  end

  defp language_tag__635(rest, acc, stack, context, line, offset) do
    language_tag__636(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__636(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__637(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__636(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__633(rest, acc, stack, context, line, offset)
  end

  defp language_tag__637(rest, acc, stack, context, line, offset) do
    language_tag__639(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__639(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__640(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__639(rest, acc, stack, context, line, offset) do
    language_tag__638(rest, acc, stack, context, line, offset)
  end

  defp language_tag__638(rest, acc, [_ | stack], context, line, offset) do
    language_tag__641(rest, acc, stack, context, line, offset)
  end

  defp language_tag__640(rest, acc, [1 | stack], context, line, offset) do
    language_tag__641(rest, acc, stack, context, line, offset)
  end

  defp language_tag__640(rest, acc, [count | stack], context, line, offset) do
    language_tag__639(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__641(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__642(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__633(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__643(rest, acc, stack, context, line, offset)
  end

  defp language_tag__642(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__634(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__643(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__644(
      rest,
      [attributes: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__644(rest, acc, stack, context, line, offset) do
    language_tag__645(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__645(rest, acc, stack, context, line, offset) do
    language_tag__647(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__647(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__648(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__647(rest, acc, stack, context, line, offset) do
    language_tag__646(rest, acc, stack, context, line, offset)
  end

  defp language_tag__648(rest, acc, stack, context, line, offset) do
    language_tag__652(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__650(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__649(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__651(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__650(rest, [], stack, context, line, offset)
  end

  defp language_tag__652(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__653(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__652(rest, acc, stack, context, line, offset) do
    language_tag__651(rest, acc, stack, context, line, offset)
  end

  defp language_tag__653(rest, acc, stack, context, line, offset) do
    language_tag__654(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__654(rest, acc, stack, context, line, offset) do
    language_tag__655(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__655(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__656(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__655(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__651(rest, acc, stack, context, line, offset)
  end

  defp language_tag__656(rest, acc, stack, context, line, offset) do
    language_tag__658(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__658(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__659(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__658(rest, acc, stack, context, line, offset) do
    language_tag__657(rest, acc, stack, context, line, offset)
  end

  defp language_tag__657(rest, acc, [_ | stack], context, line, offset) do
    language_tag__660(rest, acc, stack, context, line, offset)
  end

  defp language_tag__659(rest, acc, [1 | stack], context, line, offset) do
    language_tag__660(rest, acc, stack, context, line, offset)
  end

  defp language_tag__659(rest, acc, [count | stack], context, line, offset) do
    language_tag__658(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__660(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__661(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__661(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__662(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__662(rest, acc, stack, context, line, offset) do
    language_tag__664(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__664(rest, acc, stack, context, line, offset) do
    language_tag__665(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__665(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__666(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__665(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__663(rest, acc, stack, context, line, offset)
  end

  defp language_tag__666(rest, acc, stack, context, line, offset) do
    language_tag__667(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__667(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__668(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__667(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__663(rest, acc, stack, context, line, offset)
  end

  defp language_tag__668(rest, acc, stack, context, line, offset) do
    language_tag__670(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__670(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__671(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__670(rest, acc, stack, context, line, offset) do
    language_tag__669(rest, acc, stack, context, line, offset)
  end

  defp language_tag__669(rest, acc, [_ | stack], context, line, offset) do
    language_tag__672(rest, acc, stack, context, line, offset)
  end

  defp language_tag__671(rest, acc, [1 | stack], context, line, offset) do
    language_tag__672(rest, acc, stack, context, line, offset)
  end

  defp language_tag__671(rest, acc, [count | stack], context, line, offset) do
    language_tag__670(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__672(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__673(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__673(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__674(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__663(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__675(rest, acc, stack, context, line, offset)
  end

  defp language_tag__674(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__664(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__675(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__649(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__646(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__676(rest, acc, stack, context, line, offset)
  end

  defp language_tag__649(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__647(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__676(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__677(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__677(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__587(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__587(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__678(
      rest,
      [combine_attributes_and_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__678(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__679(
      rest,
      [
        locale:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__679(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__290(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__290(rest, acc, stack, context, line, offset) do
    language_tag__681(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__681(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__682(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__681(rest, acc, stack, context, line, offset) do
    language_tag__680(rest, acc, stack, context, line, offset)
  end

  defp language_tag__682(rest, acc, stack, context, line, offset) do
    language_tag__976(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__684(rest, acc, stack, context, line, offset) do
    language_tag__685(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__685(rest, acc, stack, context, line, offset) do
    language_tag__686(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__686(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 48 and x0 <= 57) or (x0 >= 97 and x0 <= 115) or (x0 >= 65 and x0 <= 83) or
              (x0 >= 118 and x0 <= 119) or (x0 >= 86 and x0 <= 87) or (x0 >= 121 and x0 <= 122) or
              (x0 >= 89 and x0 <= 90) do
    language_tag__687(
      rest,
      [type: <<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp language_tag__686(rest, _acc, stack, context, line, offset) do
    [_, _, _, acc | stack] = stack
    language_tag__680(rest, acc, stack, context, line, offset)
  end

  defp language_tag__687(rest, acc, stack, context, line, offset) do
    language_tag__688(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__688(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__689(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__688(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    language_tag__680(rest, acc, stack, context, line, offset)
  end

  defp language_tag__689(rest, acc, stack, context, line, offset) do
    language_tag__690(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__690(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) do
    language_tag__691(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp language_tag__690(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, _, acc | stack] = stack
    language_tag__680(rest, acc, stack, context, line, offset)
  end

  defp language_tag__691(rest, acc, stack, context, line, offset) do
    language_tag__693(rest, acc, [6 | stack], context, line, offset)
  end

  defp language_tag__693(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__694(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__693(rest, acc, stack, context, line, offset) do
    language_tag__692(rest, acc, stack, context, line, offset)
  end

  defp language_tag__692(rest, acc, [_ | stack], context, line, offset) do
    language_tag__695(rest, acc, stack, context, line, offset)
  end

  defp language_tag__694(rest, acc, [1 | stack], context, line, offset) do
    language_tag__695(rest, acc, stack, context, line, offset)
  end

  defp language_tag__694(rest, acc, [count | stack], context, line, offset) do
    language_tag__693(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__695(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__696(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__696(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__697(
      rest,
      [
        attribute:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__697(rest, acc, stack, context, line, offset) do
    language_tag__699(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__699(rest, acc, stack, context, line, offset) do
    language_tag__700(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__700(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__701(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__700(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__698(rest, acc, stack, context, line, offset)
  end

  defp language_tag__701(rest, acc, stack, context, line, offset) do
    language_tag__702(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__702(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) do
    language_tag__703(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp language_tag__702(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__698(rest, acc, stack, context, line, offset)
  end

  defp language_tag__703(rest, acc, stack, context, line, offset) do
    language_tag__705(rest, acc, [6 | stack], context, line, offset)
  end

  defp language_tag__705(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__706(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__705(rest, acc, stack, context, line, offset) do
    language_tag__704(rest, acc, stack, context, line, offset)
  end

  defp language_tag__704(rest, acc, [_ | stack], context, line, offset) do
    language_tag__707(rest, acc, stack, context, line, offset)
  end

  defp language_tag__706(rest, acc, [1 | stack], context, line, offset) do
    language_tag__707(rest, acc, stack, context, line, offset)
  end

  defp language_tag__706(rest, acc, [count | stack], context, line, offset) do
    language_tag__705(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__707(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__708(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__708(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__709(
      rest,
      [
        attribute:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__698(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__710(rest, acc, stack, context, line, offset)
  end

  defp language_tag__709(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__699(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__710(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__711(
      rest,
      [collapse_extension(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__711(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__712(
      rest,
      [
        extension:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__712(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__683(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__713(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__684(rest, [], stack, context, line, offset)
  end

  defp language_tag__714(rest, acc, stack, context, line, offset) do
    language_tag__715(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__715(rest, acc, stack, context, line, offset) do
    language_tag__716(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__716(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 116 or x0 === 84 do
    language_tag__717(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__716(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__713(rest, acc, stack, context, line, offset)
  end

  defp language_tag__717(rest, acc, stack, context, line, offset) do
    language_tag__721(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__719(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__718(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__720(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__719(rest, [], stack, context, line, offset)
  end

  defp language_tag__721(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__722(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__721(rest, acc, stack, context, line, offset) do
    language_tag__720(rest, acc, stack, context, line, offset)
  end

  defp language_tag__722(rest, acc, stack, context, line, offset) do
    language_tag__723(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__723(rest, acc, stack, context, line, offset) do
    language_tag__861(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__725(rest, acc, stack, context, line, offset) do
    language_tag__726(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__726(rest, acc, stack, context, line, offset) do
    language_tag__727(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__727(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) do
    language_tag__728(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp language_tag__727(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    language_tag__720(rest, acc, stack, context, line, offset)
  end

  defp language_tag__728(rest, acc, stack, context, line, offset) do
    language_tag__730(rest, acc, [1 | stack], context, line, offset)
  end

  defp language_tag__730(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) do
    language_tag__731(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__730(rest, acc, stack, context, line, offset) do
    language_tag__729(rest, acc, stack, context, line, offset)
  end

  defp language_tag__729(rest, acc, [_ | stack], context, line, offset) do
    language_tag__732(rest, acc, stack, context, line, offset)
  end

  defp language_tag__731(rest, acc, [1 | stack], context, line, offset) do
    language_tag__732(rest, acc, stack, context, line, offset)
  end

  defp language_tag__731(rest, acc, [count | stack], context, line, offset) do
    language_tag__730(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__732(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__733(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__733(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__734(
      rest,
      [
        language:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__734(rest, acc, stack, context, line, offset) do
    language_tag__738(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__736(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__735(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__737(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__736(rest, [], stack, context, line, offset)
  end

  defp language_tag__738(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__739(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__738(rest, acc, stack, context, line, offset) do
    language_tag__737(rest, acc, stack, context, line, offset)
  end

  defp language_tag__739(rest, acc, stack, context, line, offset) do
    language_tag__740(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__740(rest, acc, stack, context, line, offset) do
    language_tag__742(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__742(rest, acc, stack, context, line, offset) do
    language_tag__747(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__744(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__745(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__744(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__741(rest, acc, stack, context, line, offset)
  end

  defp language_tag__745(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__743(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__746(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__744(rest, [], stack, context, line, offset)
  end

  defp language_tag__747(rest, acc, stack, context, line, offset) do
    language_tag__748(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__748(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__749(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__748(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__746(rest, acc, stack, context, line, offset)
  end

  defp language_tag__749(rest, acc, stack, context, line, offset) do
    language_tag__751(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__751(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__752(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__751(rest, acc, stack, context, line, offset) do
    language_tag__750(rest, acc, stack, context, line, offset)
  end

  defp language_tag__750(rest, acc, [_ | stack], context, line, offset) do
    language_tag__753(rest, acc, stack, context, line, offset)
  end

  defp language_tag__752(rest, acc, [1 | stack], context, line, offset) do
    language_tag__753(rest, acc, stack, context, line, offset)
  end

  defp language_tag__752(rest, acc, [count | stack], context, line, offset) do
    language_tag__751(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__753(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__754(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__754(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__743(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__743(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__755(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__755(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__737(rest, acc, stack, context, line, offset)
  end

  defp language_tag__741(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__756(rest, acc, stack, context, line, offset)
  end

  defp language_tag__756(rest, acc, stack, context, line, offset) do
    language_tag__836(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__758(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) do
    language_tag__759(
      rest,
      [language_subtags: [<<x0::integer, x1::integer, x2::integer>>]] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__758(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__737(rest, acc, stack, context, line, offset)
  end

  defp language_tag__759(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__757(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__760(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__758(rest, [], stack, context, line, offset)
  end

  defp language_tag__761(
         <<x0, x1, x2, x3, x4, x5, x6, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) do
    language_tag__762(
      rest,
      [<<x4::integer, x5::integer, x6::integer>>, <<x0::integer, x1::integer, x2::integer>>] ++
        acc,
      stack,
      context,
      comb__line,
      comb__offset + 7
    )
  end

  defp language_tag__761(rest, acc, stack, context, line, offset) do
    language_tag__760(rest, acc, stack, context, line, offset)
  end

  defp language_tag__762(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__757(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__763(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__761(rest, [], stack, context, line, offset)
  end

  defp language_tag__764(
         <<x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 and
              ((x8 >= 97 and x8 <= 122) or (x8 >= 65 and x8 <= 90)) and
              ((x9 >= 97 and x9 <= 122) or (x9 >= 65 and x9 <= 90)) and
              ((x10 >= 97 and x10 <= 122) or (x10 >= 65 and x10 <= 90)) do
    language_tag__765(
      rest,
      [
        <<x8::integer, x9::integer, x10::integer>>,
        <<x4::integer, x5::integer, x6::integer>>,
        <<x0::integer, x1::integer, x2::integer>>
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 11
    )
  end

  defp language_tag__764(rest, acc, stack, context, line, offset) do
    language_tag__763(rest, acc, stack, context, line, offset)
  end

  defp language_tag__765(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__757(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__766(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__764(rest, [], stack, context, line, offset)
  end

  defp language_tag__767(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 do
    language_tag__768(
      rest,
      [language_subtags: [<<x0::integer, x1::integer, x2::integer>>]] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__767(rest, acc, stack, context, line, offset) do
    language_tag__766(rest, acc, stack, context, line, offset)
  end

  defp language_tag__768(rest, acc, stack, context, line, offset) do
    language_tag__769(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__769(rest, acc, stack, context, line, offset) do
    language_tag__770(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__770(rest, acc, stack, context, line, offset) do
    language_tag__772(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__772(rest, acc, stack, context, line, offset) do
    language_tag__777(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__774(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__775(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__774(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__771(rest, acc, stack, context, line, offset)
  end

  defp language_tag__775(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__773(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__776(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__774(rest, [], stack, context, line, offset)
  end

  defp language_tag__777(rest, acc, stack, context, line, offset) do
    language_tag__778(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__778(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__779(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__778(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__776(rest, acc, stack, context, line, offset)
  end

  defp language_tag__779(rest, acc, stack, context, line, offset) do
    language_tag__781(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__781(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__782(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__781(rest, acc, stack, context, line, offset) do
    language_tag__780(rest, acc, stack, context, line, offset)
  end

  defp language_tag__780(rest, acc, [_ | stack], context, line, offset) do
    language_tag__783(rest, acc, stack, context, line, offset)
  end

  defp language_tag__782(rest, acc, [1 | stack], context, line, offset) do
    language_tag__783(rest, acc, stack, context, line, offset)
  end

  defp language_tag__782(rest, acc, [count | stack], context, line, offset) do
    language_tag__781(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__783(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__784(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__784(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__773(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__773(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__785(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__785(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__766(rest, acc, stack, context, line, offset)
  end

  defp language_tag__771(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__786(rest, acc, stack, context, line, offset)
  end

  defp language_tag__786(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__787(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__786(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__766(rest, acc, stack, context, line, offset)
  end

  defp language_tag__787(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__788(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__788(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__757(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__789(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__767(rest, [], stack, context, line, offset)
  end

  defp language_tag__790(
         <<x0, x1, x2, x3, x4, x5, x6, x7, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 do
    language_tag__791(
      rest,
      [
        language_subtags: [
          <<x0::integer, x1::integer, x2::integer>>,
          <<x4::integer, x5::integer, x6::integer>>
        ]
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 8
    )
  end

  defp language_tag__790(rest, acc, stack, context, line, offset) do
    language_tag__789(rest, acc, stack, context, line, offset)
  end

  defp language_tag__791(rest, acc, stack, context, line, offset) do
    language_tag__792(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__792(rest, acc, stack, context, line, offset) do
    language_tag__793(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__793(rest, acc, stack, context, line, offset) do
    language_tag__795(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__795(rest, acc, stack, context, line, offset) do
    language_tag__800(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__797(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__798(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__797(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__794(rest, acc, stack, context, line, offset)
  end

  defp language_tag__798(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__796(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__799(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__797(rest, [], stack, context, line, offset)
  end

  defp language_tag__800(rest, acc, stack, context, line, offset) do
    language_tag__801(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__801(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__802(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__801(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__799(rest, acc, stack, context, line, offset)
  end

  defp language_tag__802(rest, acc, stack, context, line, offset) do
    language_tag__804(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__804(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__805(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__804(rest, acc, stack, context, line, offset) do
    language_tag__803(rest, acc, stack, context, line, offset)
  end

  defp language_tag__803(rest, acc, [_ | stack], context, line, offset) do
    language_tag__806(rest, acc, stack, context, line, offset)
  end

  defp language_tag__805(rest, acc, [1 | stack], context, line, offset) do
    language_tag__806(rest, acc, stack, context, line, offset)
  end

  defp language_tag__805(rest, acc, [count | stack], context, line, offset) do
    language_tag__804(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__806(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__807(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__807(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__796(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__796(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__808(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__808(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__789(rest, acc, stack, context, line, offset)
  end

  defp language_tag__794(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__809(rest, acc, stack, context, line, offset)
  end

  defp language_tag__809(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__810(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__809(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__789(rest, acc, stack, context, line, offset)
  end

  defp language_tag__810(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__811(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__811(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__757(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__812(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__790(rest, [], stack, context, line, offset)
  end

  defp language_tag__813(
         <<x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and x3 === 45 and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) and
              ((x5 >= 97 and x5 <= 122) or (x5 >= 65 and x5 <= 90)) and
              ((x6 >= 97 and x6 <= 122) or (x6 >= 65 and x6 <= 90)) and x7 === 45 and
              ((x8 >= 97 and x8 <= 122) or (x8 >= 65 and x8 <= 90)) and
              ((x9 >= 97 and x9 <= 122) or (x9 >= 65 and x9 <= 90)) and
              ((x10 >= 97 and x10 <= 122) or (x10 >= 65 and x10 <= 90)) and x11 === 45 do
    language_tag__814(
      rest,
      [
        language_subtags: [
          <<x0::integer, x1::integer, x2::integer>>,
          <<x4::integer, x5::integer, x6::integer>>,
          <<x8::integer, x9::integer, x10::integer>>
        ]
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 12
    )
  end

  defp language_tag__813(rest, acc, stack, context, line, offset) do
    language_tag__812(rest, acc, stack, context, line, offset)
  end

  defp language_tag__814(rest, acc, stack, context, line, offset) do
    language_tag__815(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__815(rest, acc, stack, context, line, offset) do
    language_tag__816(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__816(rest, acc, stack, context, line, offset) do
    language_tag__818(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__818(rest, acc, stack, context, line, offset) do
    language_tag__823(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__820(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__821(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__820(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__817(rest, acc, stack, context, line, offset)
  end

  defp language_tag__821(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__819(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__822(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__820(rest, [], stack, context, line, offset)
  end

  defp language_tag__823(rest, acc, stack, context, line, offset) do
    language_tag__824(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__824(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__825(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__824(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__822(rest, acc, stack, context, line, offset)
  end

  defp language_tag__825(rest, acc, stack, context, line, offset) do
    language_tag__827(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__827(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__828(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__827(rest, acc, stack, context, line, offset) do
    language_tag__826(rest, acc, stack, context, line, offset)
  end

  defp language_tag__826(rest, acc, [_ | stack], context, line, offset) do
    language_tag__829(rest, acc, stack, context, line, offset)
  end

  defp language_tag__828(rest, acc, [1 | stack], context, line, offset) do
    language_tag__829(rest, acc, stack, context, line, offset)
  end

  defp language_tag__828(rest, acc, [count | stack], context, line, offset) do
    language_tag__827(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__829(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__830(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__830(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__819(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__819(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__831(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__831(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__812(rest, acc, stack, context, line, offset)
  end

  defp language_tag__817(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__832(rest, acc, stack, context, line, offset)
  end

  defp language_tag__832(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__833(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__832(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__812(rest, acc, stack, context, line, offset)
  end

  defp language_tag__833(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__834(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__834(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__757(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__835(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__813(rest, [], stack, context, line, offset)
  end

  defp language_tag__836(rest, acc, stack, context, line, offset) do
    language_tag__837(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__837(rest, acc, stack, context, line, offset) do
    language_tag__838(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__838(rest, acc, stack, context, line, offset) do
    language_tag__840(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__840(rest, acc, stack, context, line, offset) do
    language_tag__845(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__842(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__843(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__842(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__839(rest, acc, stack, context, line, offset)
  end

  defp language_tag__843(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__841(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__844(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__842(rest, [], stack, context, line, offset)
  end

  defp language_tag__845(rest, acc, stack, context, line, offset) do
    language_tag__846(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__846(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__847(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__846(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__844(rest, acc, stack, context, line, offset)
  end

  defp language_tag__847(rest, acc, stack, context, line, offset) do
    language_tag__849(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__849(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__850(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__849(rest, acc, stack, context, line, offset) do
    language_tag__848(rest, acc, stack, context, line, offset)
  end

  defp language_tag__848(rest, acc, [_ | stack], context, line, offset) do
    language_tag__851(rest, acc, stack, context, line, offset)
  end

  defp language_tag__850(rest, acc, [1 | stack], context, line, offset) do
    language_tag__851(rest, acc, stack, context, line, offset)
  end

  defp language_tag__850(rest, acc, [count | stack], context, line, offset) do
    language_tag__849(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__851(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__852(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__852(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__841(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__841(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__853(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__853(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__835(rest, acc, stack, context, line, offset)
  end

  defp language_tag__839(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__854(rest, acc, stack, context, line, offset)
  end

  defp language_tag__854(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__855(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__854(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__835(rest, acc, stack, context, line, offset)
  end

  defp language_tag__855(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__856(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__856(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__757(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__757(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__735(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__735(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__724(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__857(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__725(rest, [], stack, context, line, offset)
  end

  defp language_tag__858(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__859(
      rest,
      [language: <<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__858(rest, acc, stack, context, line, offset) do
    language_tag__857(rest, acc, stack, context, line, offset)
  end

  defp language_tag__859(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__724(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__860(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__858(rest, [], stack, context, line, offset)
  end

  defp language_tag__861(rest, acc, stack, context, line, offset) do
    language_tag__862(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__862(rest, acc, stack, context, line, offset) do
    language_tag__863(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__863(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90)) do
    language_tag__864(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__863(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__860(rest, acc, stack, context, line, offset)
  end

  defp language_tag__864(rest, acc, stack, context, line, offset) do
    language_tag__866(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__866(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) do
    language_tag__867(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__866(rest, acc, stack, context, line, offset) do
    language_tag__865(rest, acc, stack, context, line, offset)
  end

  defp language_tag__865(rest, acc, [_ | stack], context, line, offset) do
    language_tag__868(rest, acc, stack, context, line, offset)
  end

  defp language_tag__867(rest, acc, [1 | stack], context, line, offset) do
    language_tag__868(rest, acc, stack, context, line, offset)
  end

  defp language_tag__867(rest, acc, [count | stack], context, line, offset) do
    language_tag__866(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__868(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__869(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__869(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__870(
      rest,
      [
        language:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__870(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__724(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__724(rest, acc, stack, context, line, offset) do
    language_tag__874(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__872(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__871(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__873(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__872(rest, [], stack, context, line, offset)
  end

  defp language_tag__874(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__875(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__874(rest, acc, stack, context, line, offset) do
    language_tag__873(rest, acc, stack, context, line, offset)
  end

  defp language_tag__875(rest, acc, stack, context, line, offset) do
    language_tag__876(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__876(rest, acc, stack, context, line, offset) do
    language_tag__877(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__877(rest, acc, stack, context, line, offset) do
    language_tag__879(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__879(rest, acc, stack, context, line, offset) do
    language_tag__884(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__881(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__882(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__881(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__878(rest, acc, stack, context, line, offset)
  end

  defp language_tag__882(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__880(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__883(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__881(rest, [], stack, context, line, offset)
  end

  defp language_tag__884(rest, acc, stack, context, line, offset) do
    language_tag__885(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__885(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__886(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__885(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__883(rest, acc, stack, context, line, offset)
  end

  defp language_tag__886(rest, acc, stack, context, line, offset) do
    language_tag__888(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__888(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__889(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__888(rest, acc, stack, context, line, offset) do
    language_tag__887(rest, acc, stack, context, line, offset)
  end

  defp language_tag__887(rest, acc, [_ | stack], context, line, offset) do
    language_tag__890(rest, acc, stack, context, line, offset)
  end

  defp language_tag__889(rest, acc, [1 | stack], context, line, offset) do
    language_tag__890(rest, acc, stack, context, line, offset)
  end

  defp language_tag__889(rest, acc, [count | stack], context, line, offset) do
    language_tag__888(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__890(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__891(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__891(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__880(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__880(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__892(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__892(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__873(rest, acc, stack, context, line, offset)
  end

  defp language_tag__878(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__893(rest, acc, stack, context, line, offset)
  end

  defp language_tag__893(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90)) do
    language_tag__894(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__893(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__873(rest, acc, stack, context, line, offset)
  end

  defp language_tag__894(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__895(
      rest,
      [
        script:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__895(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__871(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__871(rest, acc, stack, context, line, offset) do
    language_tag__899(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__897(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__896(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__898(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__897(rest, [], stack, context, line, offset)
  end

  defp language_tag__899(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__900(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__899(rest, acc, stack, context, line, offset) do
    language_tag__898(rest, acc, stack, context, line, offset)
  end

  defp language_tag__900(rest, acc, stack, context, line, offset) do
    language_tag__901(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__901(rest, acc, stack, context, line, offset) do
    language_tag__902(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__902(rest, acc, stack, context, line, offset) do
    language_tag__904(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__904(rest, acc, stack, context, line, offset) do
    language_tag__909(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__906(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__907(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__906(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__903(rest, acc, stack, context, line, offset)
  end

  defp language_tag__907(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__905(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__908(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__906(rest, [], stack, context, line, offset)
  end

  defp language_tag__909(rest, acc, stack, context, line, offset) do
    language_tag__910(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__910(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__911(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__910(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__908(rest, acc, stack, context, line, offset)
  end

  defp language_tag__911(rest, acc, stack, context, line, offset) do
    language_tag__913(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__913(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__914(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__913(rest, acc, stack, context, line, offset) do
    language_tag__912(rest, acc, stack, context, line, offset)
  end

  defp language_tag__912(rest, acc, [_ | stack], context, line, offset) do
    language_tag__915(rest, acc, stack, context, line, offset)
  end

  defp language_tag__914(rest, acc, [1 | stack], context, line, offset) do
    language_tag__915(rest, acc, stack, context, line, offset)
  end

  defp language_tag__914(rest, acc, [count | stack], context, line, offset) do
    language_tag__913(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__915(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__916(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__916(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__905(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__905(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__917(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__917(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    [acc | stack] = stack
    language_tag__898(rest, acc, stack, context, line, offset)
  end

  defp language_tag__903(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__918(rest, acc, stack, context, line, offset)
  end

  defp language_tag__918(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90)) do
    language_tag__919(
      rest,
      [<<x0::integer, x1::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp language_tag__918(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) do
    language_tag__919(
      rest,
      [x2 - 48 + (x1 - 48) * 10 + (x0 - 48) * 100] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__918(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__898(rest, acc, stack, context, line, offset)
  end

  defp language_tag__919(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__920(
      rest,
      [
        territory:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__920(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__896(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__896(rest, acc, stack, context, line, offset) do
    language_tag__922(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__922(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__923(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__922(rest, acc, stack, context, line, offset) do
    language_tag__921(rest, acc, stack, context, line, offset)
  end

  defp language_tag__923(rest, acc, stack, context, line, offset) do
    language_tag__924(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__924(rest, acc, stack, context, line, offset) do
    language_tag__929(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__926(
         <<x0, x1, x2, x3, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) do
    language_tag__927(
      rest,
      [Enum.join([<<x0::integer>>, <<x1::integer, x2::integer, x3::integer>>])] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp language_tag__926(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    language_tag__921(rest, acc, stack, context, line, offset)
  end

  defp language_tag__927(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__925(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__928(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__926(rest, [], stack, context, line, offset)
  end

  defp language_tag__929(rest, acc, stack, context, line, offset) do
    language_tag__930(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__930(
         <<x0, x1, x2, x3, x4, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) and
              ((x3 >= 97 and x3 <= 122) or (x3 >= 65 and x3 <= 90) or (x3 >= 48 and x3 <= 57)) and
              ((x4 >= 97 and x4 <= 122) or (x4 >= 65 and x4 <= 90) or (x4 >= 48 and x4 <= 57)) do
    language_tag__931(
      rest,
      [<<x0::integer, x1::integer, x2::integer, x3::integer, x4::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 5
    )
  end

  defp language_tag__930(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__928(rest, acc, stack, context, line, offset)
  end

  defp language_tag__931(rest, acc, stack, context, line, offset) do
    language_tag__933(rest, acc, [3 | stack], context, line, offset)
  end

  defp language_tag__933(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__934(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__933(rest, acc, stack, context, line, offset) do
    language_tag__932(rest, acc, stack, context, line, offset)
  end

  defp language_tag__932(rest, acc, [_ | stack], context, line, offset) do
    language_tag__935(rest, acc, stack, context, line, offset)
  end

  defp language_tag__934(rest, acc, [1 | stack], context, line, offset) do
    language_tag__935(rest, acc, stack, context, line, offset)
  end

  defp language_tag__934(rest, acc, [count | stack], context, line, offset) do
    language_tag__933(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__935(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__936(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__936(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__925(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__925(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__937(
      rest,
      [
        language_variant:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__921(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__938(rest, acc, stack, context, line, offset)
  end

  defp language_tag__937(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__922(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__938(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__939(
      rest,
      [collapse_variants(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__939(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__718(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__718(rest, acc, stack, context, line, offset) do
    language_tag__940(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__940(rest, acc, stack, context, line, offset) do
    language_tag__942(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__942(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__943(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__942(rest, acc, stack, context, line, offset) do
    language_tag__941(rest, acc, stack, context, line, offset)
  end

  defp language_tag__943(rest, acc, stack, context, line, offset) do
    language_tag__947(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__945(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__944(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__946(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__945(rest, [], stack, context, line, offset)
  end

  defp language_tag__947(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__948(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__947(rest, acc, stack, context, line, offset) do
    language_tag__946(rest, acc, stack, context, line, offset)
  end

  defp language_tag__948(rest, acc, stack, context, line, offset) do
    language_tag__949(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__949(rest, acc, stack, context, line, offset) do
    language_tag__950(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__950(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__951(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__950(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__946(rest, acc, stack, context, line, offset)
  end

  defp language_tag__951(rest, acc, stack, context, line, offset) do
    language_tag__953(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__953(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__954(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__953(rest, acc, stack, context, line, offset) do
    language_tag__952(rest, acc, stack, context, line, offset)
  end

  defp language_tag__952(rest, acc, [_ | stack], context, line, offset) do
    language_tag__955(rest, acc, stack, context, line, offset)
  end

  defp language_tag__954(rest, acc, [1 | stack], context, line, offset) do
    language_tag__955(rest, acc, stack, context, line, offset)
  end

  defp language_tag__954(rest, acc, [count | stack], context, line, offset) do
    language_tag__953(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__955(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__956(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__956(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__957(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__957(rest, acc, stack, context, line, offset) do
    language_tag__959(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__959(rest, acc, stack, context, line, offset) do
    language_tag__960(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__960(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__961(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__960(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__958(rest, acc, stack, context, line, offset)
  end

  defp language_tag__961(rest, acc, stack, context, line, offset) do
    language_tag__962(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__962(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__963(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__962(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__958(rest, acc, stack, context, line, offset)
  end

  defp language_tag__963(rest, acc, stack, context, line, offset) do
    language_tag__965(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__965(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__966(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__965(rest, acc, stack, context, line, offset) do
    language_tag__964(rest, acc, stack, context, line, offset)
  end

  defp language_tag__964(rest, acc, [_ | stack], context, line, offset) do
    language_tag__967(rest, acc, stack, context, line, offset)
  end

  defp language_tag__966(rest, acc, [1 | stack], context, line, offset) do
    language_tag__967(rest, acc, stack, context, line, offset)
  end

  defp language_tag__966(rest, acc, [count | stack], context, line, offset) do
    language_tag__965(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__967(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__968(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__968(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__969(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__958(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__970(rest, acc, stack, context, line, offset)
  end

  defp language_tag__969(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__959(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__970(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__944(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__941(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__971(rest, acc, stack, context, line, offset)
  end

  defp language_tag__944(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__942(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__971(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__972(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__972(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__973(
      rest,
      [merge_langtag_and_transform(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__973(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__974(
      rest,
      [
        transform:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__974(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__683(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__975(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__714(rest, [], stack, context, line, offset)
  end

  defp language_tag__976(rest, acc, stack, context, line, offset) do
    language_tag__977(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__977(rest, acc, stack, context, line, offset) do
    language_tag__978(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__978(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 117 or x0 === 85 do
    language_tag__979(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__978(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__975(rest, acc, stack, context, line, offset)
  end

  defp language_tag__979(rest, acc, stack, context, line, offset) do
    language_tag__1016(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__981(rest, acc, stack, context, line, offset) do
    language_tag__982(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__982(rest, acc, stack, context, line, offset) do
    language_tag__984(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__984(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__985(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__984(rest, acc, stack, context, line, offset) do
    language_tag__983(rest, acc, stack, context, line, offset)
  end

  defp language_tag__985(rest, acc, stack, context, line, offset) do
    language_tag__989(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__987(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__986(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__988(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__987(rest, [], stack, context, line, offset)
  end

  defp language_tag__989(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__990(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__989(rest, acc, stack, context, line, offset) do
    language_tag__988(rest, acc, stack, context, line, offset)
  end

  defp language_tag__990(rest, acc, stack, context, line, offset) do
    language_tag__991(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__991(rest, acc, stack, context, line, offset) do
    language_tag__992(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__992(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__993(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__992(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__988(rest, acc, stack, context, line, offset)
  end

  defp language_tag__993(rest, acc, stack, context, line, offset) do
    language_tag__995(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__995(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__996(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__995(rest, acc, stack, context, line, offset) do
    language_tag__994(rest, acc, stack, context, line, offset)
  end

  defp language_tag__994(rest, acc, [_ | stack], context, line, offset) do
    language_tag__997(rest, acc, stack, context, line, offset)
  end

  defp language_tag__996(rest, acc, [1 | stack], context, line, offset) do
    language_tag__997(rest, acc, stack, context, line, offset)
  end

  defp language_tag__996(rest, acc, [count | stack], context, line, offset) do
    language_tag__995(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__997(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__998(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__998(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__999(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__999(rest, acc, stack, context, line, offset) do
    language_tag__1001(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__1001(rest, acc, stack, context, line, offset) do
    language_tag__1002(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1002(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__1003(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1002(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__1000(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1003(rest, acc, stack, context, line, offset) do
    language_tag__1004(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1004(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__1005(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__1004(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__1000(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1005(rest, acc, stack, context, line, offset) do
    language_tag__1007(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__1007(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__1008(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1007(rest, acc, stack, context, line, offset) do
    language_tag__1006(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1006(rest, acc, [_ | stack], context, line, offset) do
    language_tag__1009(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1008(rest, acc, [1 | stack], context, line, offset) do
    language_tag__1009(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1008(rest, acc, [count | stack], context, line, offset) do
    language_tag__1007(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__1009(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1010(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1010(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1011(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1000(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__1012(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1011(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__1001(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__1012(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__986(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__983(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__1013(rest, acc, stack, context, line, offset)
  end

  defp language_tag__986(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__984(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__1013(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1014(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1014(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__980(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__1015(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__981(rest, [], stack, context, line, offset)
  end

  defp language_tag__1016(rest, acc, stack, context, line, offset) do
    language_tag__1017(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1017(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__1018(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1017(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__1015(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1018(rest, acc, stack, context, line, offset) do
    language_tag__1019(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1019(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__1020(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__1019(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__1015(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1020(rest, acc, stack, context, line, offset) do
    language_tag__1022(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__1022(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__1023(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1022(rest, acc, stack, context, line, offset) do
    language_tag__1021(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1021(rest, acc, [_ | stack], context, line, offset) do
    language_tag__1024(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1023(rest, acc, [1 | stack], context, line, offset) do
    language_tag__1024(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1023(rest, acc, [count | stack], context, line, offset) do
    language_tag__1022(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__1024(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1025(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1025(rest, acc, stack, context, line, offset) do
    language_tag__1027(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__1027(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__1028(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1027(rest, acc, stack, context, line, offset) do
    language_tag__1026(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1028(rest, acc, stack, context, line, offset) do
    language_tag__1029(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1029(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__1030(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__1029(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__1026(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1030(rest, acc, stack, context, line, offset) do
    language_tag__1032(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__1032(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__1033(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1032(rest, acc, stack, context, line, offset) do
    language_tag__1031(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1031(rest, acc, [_ | stack], context, line, offset) do
    language_tag__1034(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1033(rest, acc, [1 | stack], context, line, offset) do
    language_tag__1034(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1033(rest, acc, [count | stack], context, line, offset) do
    language_tag__1032(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__1034(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1035(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1026(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__1036(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1035(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__1027(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__1036(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1037(
      rest,
      [attributes: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1037(rest, acc, stack, context, line, offset) do
    language_tag__1038(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1038(rest, acc, stack, context, line, offset) do
    language_tag__1040(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__1040(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 45 and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__1041(
      rest,
      [key: <<x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__1040(rest, acc, stack, context, line, offset) do
    language_tag__1039(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1041(rest, acc, stack, context, line, offset) do
    language_tag__1045(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__1043(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__1042(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__1044(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__1043(rest, [], stack, context, line, offset)
  end

  defp language_tag__1045(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__1046(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1045(rest, acc, stack, context, line, offset) do
    language_tag__1044(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1046(rest, acc, stack, context, line, offset) do
    language_tag__1047(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1047(rest, acc, stack, context, line, offset) do
    language_tag__1048(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1048(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__1049(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__1048(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__1044(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1049(rest, acc, stack, context, line, offset) do
    language_tag__1051(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__1051(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__1052(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1051(rest, acc, stack, context, line, offset) do
    language_tag__1050(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1050(rest, acc, [_ | stack], context, line, offset) do
    language_tag__1053(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1052(rest, acc, [1 | stack], context, line, offset) do
    language_tag__1053(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1052(rest, acc, [count | stack], context, line, offset) do
    language_tag__1051(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__1053(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1054(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1054(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1055(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1055(rest, acc, stack, context, line, offset) do
    language_tag__1057(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__1057(rest, acc, stack, context, line, offset) do
    language_tag__1058(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1058(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__1059(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1058(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__1056(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1059(rest, acc, stack, context, line, offset) do
    language_tag__1060(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1060(
         <<x0, x1, x2, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when ((x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57)) and
              ((x1 >= 97 and x1 <= 122) or (x1 >= 65 and x1 <= 90) or (x1 >= 48 and x1 <= 57)) and
              ((x2 >= 97 and x2 <= 122) or (x2 >= 65 and x2 <= 90) or (x2 >= 48 and x2 <= 57)) do
    language_tag__1061(
      rest,
      [<<x0::integer, x1::integer, x2::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 3
    )
  end

  defp language_tag__1060(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__1056(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1061(rest, acc, stack, context, line, offset) do
    language_tag__1063(rest, acc, [5 | stack], context, line, offset)
  end

  defp language_tag__1063(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__1064(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1063(rest, acc, stack, context, line, offset) do
    language_tag__1062(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1062(rest, acc, [_ | stack], context, line, offset) do
    language_tag__1065(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1064(rest, acc, [1 | stack], context, line, offset) do
    language_tag__1065(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1064(rest, acc, [count | stack], context, line, offset) do
    language_tag__1063(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__1065(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1066(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1066(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1067(
      rest,
      [
        type:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1056(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__1068(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1067(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__1057(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__1068(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__1042(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__1039(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__1069(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1042(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__1040(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__1069(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1070(
      rest,
      [collapse_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1070(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__980(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__980(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1071(
      rest,
      [combine_attributes_and_keywords(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1071(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1072(
      rest,
      [
        locale:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1072(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__683(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__680(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__1073(rest, acc, stack, context, line, offset)
  end

  defp language_tag__683(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__681(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__1073(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1074(
      rest,
      [collapse_extensions(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1074(rest, acc, stack, context, line, offset) do
    language_tag__1078(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__1076(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__1075(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__1077(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    language_tag__1076(rest, [], stack, context, line, offset)
  end

  defp language_tag__1078(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__1079(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1078(rest, acc, stack, context, line, offset) do
    language_tag__1077(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1079(rest, acc, stack, context, line, offset) do
    language_tag__1080(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1080(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 === 120 or x0 === 88) and x1 === 45 do
    language_tag__1081(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp language_tag__1080(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__1077(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1081(rest, acc, stack, context, line, offset) do
    language_tag__1082(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1082(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__1083(
      rest,
      [<<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp language_tag__1082(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    language_tag__1077(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1083(rest, acc, stack, context, line, offset) do
    language_tag__1085(rest, acc, [7 | stack], context, line, offset)
  end

  defp language_tag__1085(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__1086(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1085(rest, acc, stack, context, line, offset) do
    language_tag__1084(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1084(rest, acc, [_ | stack], context, line, offset) do
    language_tag__1087(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1086(rest, acc, [1 | stack], context, line, offset) do
    language_tag__1087(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1086(rest, acc, [count | stack], context, line, offset) do
    language_tag__1085(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__1087(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1088(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1088(rest, acc, stack, context, line, offset) do
    language_tag__1090(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp language_tag__1090(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 45 do
    language_tag__1091(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1090(rest, acc, stack, context, line, offset) do
    language_tag__1089(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1091(rest, acc, stack, context, line, offset) do
    language_tag__1092(rest, [], [acc | stack], context, line, offset)
  end

  defp language_tag__1092(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__1093(
      rest,
      [<<x0::integer>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp language_tag__1092(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    language_tag__1089(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1093(rest, acc, stack, context, line, offset) do
    language_tag__1095(rest, acc, [7 | stack], context, line, offset)
  end

  defp language_tag__1095(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) do
    language_tag__1096(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp language_tag__1095(rest, acc, stack, context, line, offset) do
    language_tag__1094(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1094(rest, acc, [_ | stack], context, line, offset) do
    language_tag__1097(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1096(rest, acc, [1 | stack], context, line, offset) do
    language_tag__1097(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1096(rest, acc, [count | stack], context, line, offset) do
    language_tag__1095(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp language_tag__1097(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1098(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1089(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    language_tag__1099(rest, acc, stack, context, line, offset)
  end

  defp language_tag__1098(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    language_tag__1090(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp language_tag__1099(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    language_tag__1100(
      rest,
      [private_use: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp language_tag__1100(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__1075(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__1075(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__264(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__264(rest, user_acc, [acc | stack], context, line, offset) do
    case (case flatten(rest, user_acc, context, line, offset) do
            {_, _, _} = res -> res
            {:error, reason} -> {:error, reason}
            {acc, context} -> {rest, acc, context}
          end) do
      {rest, user_acc, context} when is_list(user_acc) ->
        language_tag__1101(rest, user_acc ++ acc, stack, context, line, offset)

      {:error, reason} ->
        {:error, reason, rest, context, line, offset}
    end
  end

  defp language_tag__1101(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__258(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__258(rest, user_acc, [acc | stack], context, line, offset) do
    case (case flatten(rest, user_acc, context, line, offset) do
            {_, _, _} = res -> res
            {:error, reason} -> {:error, reason}
            {acc, context} -> {rest, acc, context}
          end) do
      {rest, user_acc, context} when is_list(user_acc) ->
        language_tag__1102(rest, user_acc ++ acc, stack, context, line, offset)

      {:error, reason} ->
        {:error, reason, rest, context, line, offset}
    end
  end

  defp language_tag__1102(rest, acc, [_, previous_acc | stack], context, line, offset) do
    language_tag__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp language_tag__1(<<""::binary>>, acc, stack, context, comb__line, comb__offset) do
    language_tag__1103("", [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp language_tag__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected a BCP47 language tag", rest, context, line, offset}
  end

  defp language_tag__1103(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  def error_on_remaining("", context, _line, _offset) do
    {[], context}
  end

  def error_on_remaining(_rest, _context, _line, _offset) do
    {:error, "invalid language tag"}
  end
end
