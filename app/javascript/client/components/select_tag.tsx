import React from 'react';
import { ActionMeta, MultiValue, StylesConfig } from 'react-select';
import CreatableSelect from 'react-select/creatable';

export type TagOption = {
  label: string,
  value: string,
}

export type SelectTagProps = {
  tags: TagOption[],
  setTags: (tagList: string) => void,
};

const styles: StylesConfig<TagOption> = {
  control: () => ({
    display: "flex",
    width: "100%",
    minWidth: "0px",
    outline: "2px solid transparent",
    outlineOffset: "2px",
    position: "relative",
    appearance: "none",
    transitionProperty: "var(--chakra-transition-property-common)",
    transitionDuration: "var(--chakra-transition-duration-normal)",
    fontSize: "var(--chakra-fontSizes-md)",
    paddingInlineStart: "var(--chakra-space-4)",
    paddingInlineEnd: "var(--chakra-space-4)",
    borderRadius: "var(--chakra-radii-md)",
    border: "1px solid",
    borderColor: "inherit",
    background: "inherit",
    padding: "0",
    lineHeight: "inherit",
    color: "inherit",
  }),
  input: () => ({
    margin: "2px",
    paddingBottom: "2px",
    paddingTop: "2px",
    visibility: "visible",
    gridArea: "1/1/2/3",
    color: "#DEE0E2",
  }),
  menuList: () => ({
    maxHeight: "300px",
    overflowY: "auto",
    paddingBottom: "4px",
    paddingTop: "4px",
    position: "relative",
    boxSizing: "border-box",
    backgroundColor: "#28303F",
  }),
  option: () => ({
    backgroundColor: "#28303F",
    color: "inherit",
    cursor: "default",
    display: "block",
    fontSize: "inherit",
    padding: "8px 12px",
    width: "100%",
    userSelect: "none",
    boxSizing: "border-box",
  }),
  multiValue: () => ({
    backgroundColor: "#521B41",
    borderRadius: "2px",
    display: "flex",
    margin: "2px",
    minWidth: "0",
    boxSizing: "border-box",
    color: "#DEE0E2",
  }),
  multiValueLabel: () => ({
    color: "#DEE0E2",
    fontSize: "85%",
    padding: "4px",
  })
};

const SelectTag = ({ tags, setTags }: SelectTagProps) => {

  const handleChange = (newValue: MultiValue<TagOption>, actionMeta: ActionMeta<TagOption>) => {
    setTags(newValue.map(v => v.value).join(", "));
  };

  return <CreatableSelect isMulti onChange={handleChange} options={tags} styles={styles} />
}

export default SelectTag;