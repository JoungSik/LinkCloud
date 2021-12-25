import React from 'react';
import Select from 'react-select';
import { Input } from '@chakra-ui/react';

export type TagOption = {
  label: string,
  value: string,
}

export type SelectTagProps = {
  tags: TagOption[],
};

const SelectTag = ({ tags }: SelectTagProps) => {
  return <Select isMulti options={tags} />

  // components={{
  //   Control: () => <Input placeholder="Frontend, Backend" />,
  //     Input: () => <Input placeholder="Frontend, Backend" />
  // }}
}

export default SelectTag;